class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.belongs_to :user
      t.string :description

      t.timestamps
    end
    add_index :products, :user_id
  end
end
