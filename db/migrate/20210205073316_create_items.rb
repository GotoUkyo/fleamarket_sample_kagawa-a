class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :brand
      t.integer :state_id, null: false
      t.integer :postage_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :day_id, null: false
      t.integer :price, null: false
      t.integer :deal_state_id, null: false, default: 0
      t.integer :user_id, null: false, foreign_key: true
      t.string :category
      t.timestamps
    end
  end
end
