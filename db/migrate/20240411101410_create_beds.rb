class CreateBeds < ActiveRecord::Migration[7.1]
  def change
    create_table :beds do |t|
      t.string :ward_type
      t.string :bed_no
      t.string :status

      t.timestamps
    end
  end
end
