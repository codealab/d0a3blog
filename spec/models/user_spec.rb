require 'spec_helper'

describe User do

	before do
		@user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
	end

	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:photo) }
	it { should respond_to(:email) }
	it { should respond_to(:administrator) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:authenticate) }
	it { should respond_to(:remember_token) }
	it { should respond_to(:organization) }

	#relations
	it { should respond_to(:posts) }

	it { should be_valid }

	describe "when invalid atribute" do
		before do
			@user.name = " "
			@user.email = " "
			@user.password = " "
			@user.administrator = " "
			@user.password_confirmation = " "
		end

		it { should_not be_valid }
	end

end