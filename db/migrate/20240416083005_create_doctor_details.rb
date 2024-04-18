class CreateDoctorDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :doctor_details do |t|
      t.string :regno
      t.references :department, null: false, foreign_key: true
      t.time :start_time
      t.time :end_time
      t.integer :required_time_slot
      t.string :qualification
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
