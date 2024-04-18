class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :doctor, foreign_key: { to_table: :users }
      t.references :patient, null: false, foreign_key: true
      t.datetime :slot_start_datetime
      t.datetime :slot_end_datetime
      t.string :appointment_type
      t.string :status

      t.timestamps
    end
  end
end
