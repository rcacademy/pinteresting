class AddDescriptionToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :description, :text
  end
end
