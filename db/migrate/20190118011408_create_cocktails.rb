class CreateCocktails < ActiveRecord::Migration[5.1]
  def change
    create_table :cocktails do |t|
      t.string :name
      t.integer :taste_sweet_sugar
      t.integer :taste_sweet_fruit
      t.integer :taste_fresh
      t.integer :taste_bitters_fruit
      t.integer :taste_bitters_drink
      t.integer :alcohol
      t.integer :amount
      t.string :etc
      t.string :mouthfeel
      t.string :base
      t.boolean :soda
      t.string :about
      t.string :ment
      t.string :link
      t.string :photo
      
      t.timestamps
    end
  end
end
