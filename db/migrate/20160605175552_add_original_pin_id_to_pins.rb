class AddOriginalPinIdToPins < ActiveRecord::Migration
  def change
    add_column :pins, :original_pin_id, :integer
  end
end
