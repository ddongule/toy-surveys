# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Cocktail.create(name: "갓마더",taste_sweet_sugar: 1, taste_sweet_fruit: 0, taste_fresh: 0, taste_bitters_fruit: 0, taste_bitters_drink: 1, alcohol: 5, amount: 2, etc: "아몬드", mouthfeel: "물", base: "보드카", soda: false)
Cocktail.create(name: "갓파더",taste_sweet_sugar: 1, taste_sweet_fruit: 0, taste_fresh: 0, taste_bitters_fruit: 0, taste_bitters_drink: 1, alcohol: 6, amount: 2, etc: "아몬드", mouthfeel: "물", base: "위스키", soda: false)
Cocktail.create(name: "그래스호퍼",taste_sweet_sugar: 0, taste_sweet_fruit: 1, taste_fresh: 1, taste_bitters_fruit: 0, taste_bitters_drink: 0, alcohol: 3, amount: 3, etc: "민트,초코", mouthfeel: "크리미", base: "리큐르", soda: false)
Cocktail.create(name: "김렛",taste_sweet_sugar: 0, taste_sweet_fruit: 0, taste_fresh: 1, taste_bitters_fruit: 0, taste_bitters_drink: 0, alcohol: 5, amount: 3, mouthfeel: "물", base: "진", soda: false)
Cocktail.create(name: "깔루아 밀크",taste_sweet_sugar: 1, taste_sweet_fruit: 0, taste_fresh: 0, taste_bitters_fruit: 0, taste_bitters_drink: 0, alcohol: 2, amount: 2, etc: "커피,우유", mouthfeel: "우유", base: "럼", soda: false)
Cocktail.create(name: "네그로니",taste_sweet_sugar: 0, taste_sweet_fruit: 0, taste_fresh: 0, taste_bitters_fruit: 1, taste_bitters_drink: 1, alcohol: 4, amount: 2, mouthfeel: "물", base: "진", soda: false)
Cocktail.create(name: "뉴욕",taste_sweet_sugar: 1, taste_sweet_fruit: 0, taste_fresh: 1, taste_bitters_fruit: 0, taste_bitters_drink: 0, alcohol: 5, amount: 2, mouthfeel: "물", base: "위스키", soda: false)
Cocktail.create(name: "다이키리",taste_sweet_sugar: 1, taste_sweet_fruit: 0, taste_fresh: 1, taste_bitters_fruit: 0, taste_bitters_drink: 0, alcohol: 5, amount: 2, mouthfeel: "물", base: "럼", soda: false)
Cocktail.create(name: "데킬라 선라이즈",taste_sweet_sugar: 1, taste_sweet_fruit: 0, taste_fresh: 1, taste_bitters_fruit: 0, taste_bitters_drink: 0, alcohol: 3, amount: 3, mouthfeel: "물", base: "데킬라", soda: false)