#encoding: UTF-8

categories = ["Interacción oportuna", "Areas del Desarrollo", "Motricidad Gruesa", "Motricidad Delgada", "Edades"]
subcategories = ["Primer subcategoría", "Segunda subcategoría", "Tercera subcategoría", "Cuarta subcategoría", "Quinta subcategoría" ]
description = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Odio non, possimus praesentium quasi officia fugiat labore, debitis suscipit inventore nemo est officiis molestias doloribus. Libero reiciendis, iste error facere placeat!"

categories.count.to_i.times do |cat|
	category = Category.create({ name: categories[cat], description: "#{description}" })
	subcategories.count.to_i.times do |sub|
		Subcategory.create({ category_id: category.id, name: subcategories[sub], description: "#{description}" })
	end
end