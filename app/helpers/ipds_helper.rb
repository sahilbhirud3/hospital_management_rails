module IpdsHelper

  #find out ward wise all(admitted,discharged) patient count
  def self.ward_wise_all_patient_count
    bed_count = Ipd.joins(:bed)
      .group(:ward_type)
      .count
  end

  #find out ward wise all(admitted) patient count
  def self.ward_wise_admitted_patient_count
    bed_count = Ipd.joins(:bed).get_admitted
      .group(:ward_type)
      .count
  end

  #find out ward wise all(admitted,discharged) patient count
  def self.department_wise_all_patient_count
    department_counts = Ipd.joins(:bed)
      .group(:department)
      .count
    result = {}
    department_counts.each do |key, value|
      result[key.id] = { name: key.name, count: value }
    end

    result
  end

  #find out ward wise all(admitted) patient count
  def self.department_wise_admitted_patient_count
    department_counts = Ipd.joins(:bed).get_admitted
      .group(:department)
      .count
    result = {}
    department_counts.each do |key, value|
      result[key.id] = { name: key.name, count: value }
    end

    result
  end
end
