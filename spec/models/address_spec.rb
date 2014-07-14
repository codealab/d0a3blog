# encoding: UTF-8
require 'spec_helper'

describe Address do

    before do
 		  @address = Address.new(calle: "Arteaga y Salazar", num_ext:"44", num_int:"3", 
                  localidad:"Algo", colonia:"contadero", municipio: "cuajimalpa",
                  ciudad:"México",estado:"Distrito Federal", pais:"México", 
                  codigo_postal:"01190", telefono:"558130387", celular:"5512946184", 
                  email:"user@example.com")
    end

    subject { @address }

    it { should respond_to(:calle) }
    it { should respond_to(:num_ext) }
    it { should respond_to(:num_int) }
    it { should respond_to(:localidad) }
    it { should respond_to(:colonia) }
    it { should respond_to(:municipio) }
    it { should respond_to(:ciudad) }
    it { should respond_to(:estado) }
    it { should respond_to(:pais) }
    it { should respond_to(:codigo_postal) }
    it { should respond_to(:telefono) }
    it { should respond_to(:celular) }
    it { should respond_to(:email) }
    it { should respond_to(:family) }

	it { should be_valid }

	describe "when invalid atribute" do
		before do
			@address.calle = " "
			@address.num_ext = " "
			@address.ciudad = " "
			@address.estado = " "
			@address.pais = " "
			@address.email = " "
		end

		it { should have(1).error_on(:calle) }
		it { should have(1).error_on(:num_ext) }
		it { should have(1).error_on(:ciudad) }
		it { should have(1).error_on(:estado) }
		it { should have(1).error_on(:pais) }
		it { should have(1).error_on(:email) }
	end

  describe "when email format is invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo.
				foo@bar_baz.com foo@bar+baz.com]
				addresses.each do |invalid_address|
					@address.email = invalid_address
					expect(@address).not_to be_valid
				end
		end
	end

	describe "when email format is valid" do
		it "should be valid" do
			addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			addresses.each do |valid_address|
				@address.email = valid_address
				expect(@address).to be_valid
			end
		end
	end

end
