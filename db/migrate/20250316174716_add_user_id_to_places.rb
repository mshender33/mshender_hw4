class AddUserIdToPlaces < ActiveRecord::Migration[7.1]
  def change
    add_reference :places, :user, foreign_key: true
  end
end
