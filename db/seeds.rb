#encoding: UTF-8

# User.create([{ name: "Juan", email: "juan.fuentes.cabrera.89@gmail.com", password: "123qwe123", password_confirmation: "123qwe123", administrator: true },
# 			 { name: "javier", email: "javier@deceroatres.com", password: "deceroatres", password_confirmation: "deceroatres", administrator: true }])

# PostType.create([
# 	{ name:'Blog' },
# 	{ name:'Noticias' },
# 	{ name:'Eventos' },
# 	{ name:'Calendario' }
# ])

# categories = ["Interacción oportuna", "Areas del Desarrollo", "Motricidad Gruesa", "Motricidad Delgada", "Edades"]

# categories.count.to_i.times do |cat|
# 	category = Category.create({ name: categories[cat] })
# 	10.times do |post|
# 		# Post.create({ title: "Post #{post}", body: description, user_id: 1, category_id: category.id })
# 	end
# end

10.times do |post|
	Post.create({
		title: "Lorem title #{post}",
		text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Iste, non ad aut officiis, odio, quaerat facere perspiciatis repudiandae ipsum reiciendis maiores doloremque eveniet laboriosam suscipit earum et id nesciunt officia.",
		status: true,
		post_type_id: 1,
		user_id: 1,
		credits: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Iste, non ad aut officiis, odio, quaerat facere perspiciatis"
	})
end