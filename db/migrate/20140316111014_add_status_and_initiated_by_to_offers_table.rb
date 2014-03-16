class AddStatusAndInitiatedByToOffersTable < ActiveRecord::Migration
  def change
    add_column :offers, :completed, :string
    add_column :offers, :initiated_by, :string
  end
end
