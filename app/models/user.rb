# encoding: UTF-8
class User < ActiveRecord::Base

	attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

	before_save :downcase_names
	after_update :crop_user
	after_initialize :titleize_names
	before_create :create_remember_token
	before_save { self.email = email.downcase }

	has_many :groups, :dependent => :restrict_with_error
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

	#validates :name, :presence => { message: "El nombre no puede estar vacío" }
	validates :name, presence: true
	validates :name, length: { maximum: 50 }
	validates :password, length: { minimum: 6 }, :if => :password
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

	has_secure_password

	scope :facilitadores, proc {where(:facilitator => true)}

	mount_uploader :photo, PhotoUploader

	def name
		read_attribute(:name).try(:titleize)
	end	

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

	  def downcase_names
	      self.send("#{:name}=", self.send(:name).downcase) if self.send(:name)
	  end

	  def titleize_names
	      self.send("#{:name}=", self.send(:name).titleize) if self.send(:name)
	  end
end