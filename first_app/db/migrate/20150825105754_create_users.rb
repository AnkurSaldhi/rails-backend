class CreateUsers < ActiveRecord::Migration
  def change
    #table is getting created for User model
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps null: false
    end
  end
end
