class CreateIpds < ActiveRecord::Migration[7.1]
  def change
    create_table :ipds do |t|
      t.references :patient, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true
      t.string :treatment_description
      t.datetime :admission_datetime
      t.datetime :discharge_datetime
      t.references :bed, null: false, foreign_key: true
      t.string :status
      t.timestamps
    end
  end
end
