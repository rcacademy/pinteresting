class AddLikesToPins < ActiveRecord::Migration
  def change
    add_column :pins, :likes, :integer
  end
end
