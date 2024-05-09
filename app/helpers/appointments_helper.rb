module AppointmentsHelper
  SLOT_TIME_FORMAT = "%Y-%m-%d %H:%M"

  #generate all possible slot for specific doctor & in specific date
  def self.generate_all_time_slots(doctor_id, date)
    doctor = DoctorDetail.find_by(user_id: doctor_id)
    start_time = DateTime.parse(date.to_s + " " + doctor[:start_time].strftime("%H:%M:%S"))
    end_time = DateTime.parse(date.to_s + " " + doctor[:end_time].strftime("%H:%M:%S"))
    current_time = start_time
    time_slots = []
    while current_time < end_time
      time_slots << current_time.strftime(SLOT_TIME_FORMAT)
      current_time += doctor.required_time_slot.minutes
    end
    return doctor, time_slots
  end

  #optimized
  #generate all slots onward current time for specific doctor & in specific date
  def self.generate_onwards_slots(doctor_id, date)
    doctor = DoctorDetail.find_by(user_id: doctor_id)
    raise ActiveRecord::RecordNotFound if doctor.nil?

    required_time_slot = doctor.required_time_slot
    start_time = DateTime.parse(date.to_s + " " + doctor.start_time.strftime("%H:%M:%S"))
    end_time = DateTime.parse(date.to_s + " " + doctor.end_time.strftime("%H:%M:%S"))
    current_minute = DateTime.now.min
    # Calculate the number of minutes remaining until the next slot
    minutes_until_next_slot = required_time_slot - (current_minute % required_time_slot)
    next_desired_slot = DateTime.parse(date.to_s + " " + ((DateTime.now + minutes_until_next_slot.minutes).change(sec: 0)).strftime("%H:%M:%S"))
    return doctor, [] if end_time < next_desired_slot
    # Start generating time slots from the nearest desired
    # if it's before the doctor's start_time then start from the start_time of the doctor. o.w atrt from next desired slot
    current_time = next_desired_slot < start_time ? start_time : next_desired_slot

    time_slots = []
    while current_time < end_time
      # puts current_time
      time_slots << current_time.strftime(SLOT_TIME_FORMAT)
      current_time += required_time_slot.minutes
    end

    return doctor, time_slots
  end

  #generate all *available* slots onward current time for specific doctor & in specific date
  def self.available_slots(doctor_id, date = DateTime.now.strftime("%Y-%m-%d"))
    doctor, all_slots = generate_onwards_slots(doctor_id, date)
    return all_slots if all_slots.empty?
    existing_slots = Appointment.where(doctor_id: doctor_id)
                                .where("DATE(slot_start_datetime) = ?", date)
                                .where(status: "scheduled")
                                .pluck(:slot_start_datetime)
                                .map { |slot| slot.strftime(SLOT_TIME_FORMAT) }
    available_slots = all_slots - existing_slots
    available_slots
  end

  def self.department_wise_appointments(date)
    Appointment.joins(doctor: { doctor_detail: :department }).where("DATE(slot_start_datetime) = ?", date).group("departments.name").count
  end



  # schedule job for updating appointment status...if the status is scheduled for previous dates then it will changed to checked
  def self.update_status_job
    puts "Update Status called @ #{DateTime.now}"
    if Appointment.where("DATE(slot_start_datetime) < ?", Date.current).where(status:"scheduled").update(status:"checked")
      puts "Appointment Status Updated Successfully @ #{DateTime.now}"
    else
      puts "Appointment Status Not Updated Successfully @ #{DateTime.now}"
    end
  end


end
