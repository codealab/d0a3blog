#encoding: UTF-8

User.create([{ name: "Juan", email: "juan.fuentes.cabrera.89@gmail.com", password: "123qwe123", password_confirmation: "123qwe123", administrator: true },
			 { name: "javier", email: "javier@deceroatres.com", password: "deceroatres", password_confirmation: "deceroatres", administrator: true }])

categories = ["Interacción oportuna", "Areas del Desarrollo", "Motricidad Gruesa", "Motricidad Delgada", "Edades"]
subcategories = ["Primer subcategoría", "Segunda subcategoría", "Tercera subcategoría", "Cuarta subcategoría", "Quinta subcategoría" ]
description = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Odio non, possimus praesentium quasi officia fugiat labore, debitis suscipit inventore nemo est officiis molestias doloribus. Libero reiciendis, iste error facere placeat!"

categories.count.to_i.times do |cat|
	category = Category.create({ name: categories[cat], description: "#{description}" })
	subcategories.count.to_i.times do |sub|
		subcategory = Subcategory.create({ category_id: category.id, name: subcategories[sub], description: "#{description}" })
		10.times do |post|
			Post.create({ title: "Post #{post}", body: description, user_id: 1, subcategory_id: subcategory.id })
		end
	end
end