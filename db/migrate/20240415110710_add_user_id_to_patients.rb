class AddUserIdToPatients < ActiveRecord::Migration[7.1]
  def change
    add_reference :patients, :user, foreign_key: true
  end
end
