class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.string :brand
      t.integer :state_id
      t.integer :postage_id
      t.integer :area_id
      t.integer :day_id
      t.integer :price
      t.integer :deal_state_id
      t.integer :user_id
      t.timestamps
    end
  end
end
