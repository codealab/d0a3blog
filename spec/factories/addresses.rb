# encoding: UTF-8
FactoryGirl.define do
  factory :address do
		calle "Arteaga y Salazar"
		num_ext "44"
		num_int "3" 
		localidad "Algo"
		colonia "contadero"
		municipio  "cuajimalpa"                   
		ciudad "México"
		estado "Distrito Federal"
		pais "México"                   
		codigo_postal "01190"
		telefono "558130387"
		celular "5512946184"                   
		email "user@example.com"
		family
  end
end
