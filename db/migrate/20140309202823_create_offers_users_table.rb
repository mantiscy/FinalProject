class CreateOffersUsersTable < ActiveRecord::Migration
  def change
    create_table :offers_users do |t|

      t.references :offer, :null => false
      t.references :user, :null => false

    end
  end
end
