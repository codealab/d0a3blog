# encoding: UTF-8
require "csv"

def load_file(file)
	array = []
	file_text = File.read(file)
	csv = CSV.parse(file_text, :headers => true, :header_converters => :symbol)
	csv.each { |row| array << row.to_hash }
	array
end

load_file("members.csv").each { |line| Person.create(line) }
load_file("families.csv").each { |line| Family.create(line) }
load_file("family_relations.csv").each { |line| FamilyRelation.create(line) }
load_file("exercises.csv").each { |line| Exercise.create(line) }
load_file("area_relations.csv").each { |line| AreaRelation.create(line) }

Panel.create( :name => 'Demo App' )

Family.all.each do |f|
	f.family_relations.each { |rel| f.update_attributes(responsible_id:rel.person.id) if rel.person.family_roll=='Madre' }
end

User.create([{ name: "Juan", email: "juan.fuentes.cabrera.89@gmail.com", password: "123qwe123", password_confirmation: "123qwe123", admin: true },
			 { name: "Contacto", email: "contacto@codealab.mx", password: "temporal", password_confirmation: "temporal", admin: true, instructor: true },])

Area.create([{ name: "Motricidad Gruesa" },
			 { name: "Motricidad Fina" },
			 { name: "Lenguaje" },
			 { name: "Sensorial Cognositiva" },
			 { name: "Socio Emocional" },
			 { name: "Otro" }])


Concept.create({ name:'Colegiatura' })
Group.create([{ name:"Principiantes",
				user_id:2,
				assistant_id:1,
				location:"Cuajimalpa", 
				cost:1000, 
				init_date:"01/01/2014", 
				finish_date:"01/07/2014", 
				min_age:0, 
				max_age:24 },
			{	name:"Intermedios",
				user_id:2,
				assistant_id:1,
				location:"Cuajimalpa", 
				cost:1000, 
				init_date:"01/01/2014", 
				finish_date:"01/07/2014", 
				min_age:24, 
				max_age:48 },
			{	name:"Avanzados",
				user_id:2,
				assistant_id:1,
				location:"Cuajimalpa", 
				cost:1000, 
				init_date:"01/01/2014", 
				finish_date:"01/07/2014", 
				min_age:48, 
				max_age:100 }])

group = Group.first

today = Date.today
min_weeks = today-(group.min_age).weeks
max_weeks = today-(group.max_age).weeks
Person.where(dob: max_weeks..min_weeks).limit(5).each { |child| Spot.create( child_id: child.id, group_id: group.id ) }

calendar = Calendar.new(group)
calendar.monday_hour = "10:30"
calendar.thursday_hour = "08:00"
calendar.submit(:monday => true, :thursday => true)

group.lectures.limit(10).each do |lecture|
	Exercise.where("min_age <= #{group.max_age} AND max_age>= #{group.min_age}").limit(5).shuffle.each { |ex| Plan.create( :exercise_id => ex.id, :lecture_id => lecture.id ) }
	group.spots.limit(3).shuffle.each do |spot|
		lecture.attendances.build( :spot_id => spot.id )
		lecture.save
	end
end

group.spots.each do |spot|
	10.times do |x|
		date = Date.today - (13-x).weeks
		spot.payments.build(date: date, scholarship: false, amount:100)
		spot.save
 	end
end