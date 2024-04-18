class CreateTreatments < ActiveRecord::Migration[7.1]
  def change
    create_table :treatments do |t|
      t.references :ipd, null: false, foreign_key: true
      t.text :description
      t.datetime :datetime

      t.timestamps
    end
  end
end
