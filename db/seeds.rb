# encoding: UTF-8
require "csv"

User.create( name: "Juan", email: "juan.fuentes.cabrera.89@gmail.com", password: "123qwe123", password_confirmation: "123qwe123", admin: true )
User.create( name: "javier", email: "javier@deceroatres.com", password: "deceroatres", password_confirmation: "deceroatres", admin: true, facilitator: true )
Area.create([{ name: "Motricidad Gruesa" } ,{ name: "Motricidad Fina" } ,{ name: "Lenguaje" } ,{ name: "Sensorial Cognositiva" } ,{ name: "Socio Emocional" } ,{ name: "Otro" }])

def load_file(file)
	array = []
	file_text = File.read(file)
	csv = CSV.parse(file_text, :headers => true, :header_converters => :symbol)
	csv.each do |row|
		array << row.to_hash
	end
	array
end

load_file("members.csv").each do |line| 
	person = Person.new(line)
	if !person.save
		puts line
		person.errors.each do |m|
			puts m
		end
	end
end

load_file("families.csv").each do |line| 
	Family.create(line)
end

load_file("family_relations.csv").each do |line| 
	FamilyRelation.create(line)
end

load_file("exercises.csv").each do |line| 
	Exercise.create(line)
end

load_file("area_relations.csv").each do |line| 
	AreaRelation.create(line)
end

families = Family.all

families.each do |f|
	f.family_relations.each do |rel|
		if(rel.person)
			f.responsible_id = rel.person.id if rel.person.family_roll=='Madre'
		end
		f.save
	end
end

# ibarrola = Family.create(name:"AAibarrola")
# ibarrola.create_address(calle: "Arteaga y Salazar", num_ext:"44", num_int:"3", 
#               localidad:"Algo", colonia:"contadero", municipio: "cuajimalpa",
#               ciudad:"México",estado:"Distrito Federal", pais:"México", 
#               codigo_postal:"01190", telefono:"558130387", celular:"5512946184", 
#               email:"user@example.com")

Group.create( name:"Principiantes",
					    user_id:2, 
					    location:"Cuajimalpa", 
					    cost:1000, 
					    init_date:"01/01/2014", 
					    finish_date:"01/07/2014", 
					    min_age:0, 
					    max_age:24) 
Group.create( name:"Intemedios",
					    user_id:2, 
					    location:"Cuajimalpa", 
					    cost:1000, 
					    init_date:"01/01/2014", 
					    finish_date:"01/07/2014", 
					    min_age:24, 
					    max_age:48) 
Group.create( name:"Avanzados",
					    user_id:2, 
					    location:"Cuajimalpa", 
					    cost:1000, 
					    init_date:"01/01/2014", 
					    finish_date:"01/07/2014", 
					    min_age:48, 
					    max_age:100) 

# group1_enrroled = Person.where(dob: Date.today..(Date.today - 24.weeks))
# group2_enrroled = Person.where(dob: (Date.today - 24.weeks)..(Date.today - 48.weeks))
# group3_enrroled = Person.where(dob: (Date.today - 48.weeks)..(Date.today - 100.weeks))

# @group = Group.find(1)
# 	5.times do |x|
# 		person = group1_enrroled[x]
# 		tutor = person.family_relations.first.family.responsible_id
# 		@group.spots.build( tutor_id: tutor, child_id: person.id )
# 	end




# group2_enrroled
# group3_enrroled

# Person.where(dob: (Date.today - 100.weeks)..(Date.today - 48.weeks))




# Para generar spots del último grupo, se salta al primer inscrito porque lo hice a mano
# group.spots.each do |spot|
# 	10.times do |x|
# 		date = Date.today - (13-x).weeks
# 		spot.payments.build(date: date, scholarship: false, amount:100)
# 		spot.save
#   end
# end







