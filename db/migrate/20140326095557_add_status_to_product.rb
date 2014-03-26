class AddStatusToProduct < ActiveRecord::Migration
  def change
    add_column :products, :available, :string
  end
end
