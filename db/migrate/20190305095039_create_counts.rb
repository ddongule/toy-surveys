class CreateCounts < ActiveRecord::Migration[5.1]
  def change
    create_table :counts do |t|
      t.string :name
      t.integer :taste_sweet_sugar
      t.integer :taste_sweet_fruit
      t.integer :taste_fresh
      t.integer :taste_bitters_fruit
      t.integer :taste_bitters_drink
      t.integer :alcohol
      t.integer :amount
      t.string :avoid
      t.string :challenge

      t.timestamps
    end
  end
end
