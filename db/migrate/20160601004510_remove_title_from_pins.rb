class RemoveTitleFromPins < ActiveRecord::Migration
  def change
    remove_column :pins, :title
  end
end
