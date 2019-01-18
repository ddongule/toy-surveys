class CreateCocktails < ActiveRecord::Migration[5.1]
  def change
    create_table :cocktails do |t|
      t.integer :taste_sweet_sugar
      t.integer :taste_sweet_fruit
      t.integer :taste_fresh
      t.integer :taste_bitters_fruit
      t.integer :taste_bitters_drink
      t.integer :alcohol
      t.integer :quantity
      t.string :etc
      t.string :mouthfeel
      t.string :base
      t.boolean :soda
      
      t.timestamps
    end
  end
end
