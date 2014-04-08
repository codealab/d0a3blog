# encoding: UTF-8
require "csv"

User.create( name: "Juan", email: "juan.fuentes.cabrera.89@gmail.com", password: "123qwe123", password_confirmation: "123qwe123", admin: true )
User.create( name: "javier", email: "javier@deceroatres.com", password: "deceroatres", password_confirmation: "deceroatres", admin: true )
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
	Person.create(line)
end

load_file("families.csv").each do |line| 
	Family.create(line)
end

load_file("family_relations.csv").each do |line| 
	FamilyRelation.create(line)
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