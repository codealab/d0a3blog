#encoding: UTF-8
class User < ActiveRecord::Base

	attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

	has_many :posts

	before_create :create_remember_token

	mount_uploader :photo, PhotoUploader
	after_update :crop_user

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

	validates :name, presence: true
	validates :name, length: { maximum: 50 }
	validates :password, length: { minimum: 6 }, :if => :password
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

	has_secure_password

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
    	Digest::SHA1.hexdigest(token.to_s)
	end

	def crop_user
		photo.recreate_versions! if crop_x.present?			
	end

	private

		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
end