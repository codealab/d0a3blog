class Family < ActiveRecord::Base
	before_save :downcase_names
	after_initialize :titleize_names

	has_many :family_relations
	has_many :family_members, through: :family_relations, source: :person, :dependent => :restrict_with_error
	has_many :spots, through: :family_members
	has_many :payments, through: :spots

	belongs_to :responsible, :class_name => 'Person'

	validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }

	has_one :address, :dependent => :destroy

	self.per_page = 15

	def styled_address
	 direccion = "#{self.address.calle},#{self.address.num_ext} ,int #{self.address.num_int},#{self.address.localidad},#{self.address.colonia}, #{self.address.municipio}, #{self.address.ciudad}, #{self.address.estado}, #{self.address.pais}, #{self.address.codigo_postal}"
		direccion.titleize
	end
	def styled_contact_info
		"Tel: #{self.address.telefono}, Cel: #{self.address.celular}, Email: #{self.address.email}"
	end

	private

	  def downcase_names
	    self.send("#{:name}=", self.send(:name).downcase) if self.send(:name)
	  end

	  def titleize_names
	    self.send("#{:name}=", self.send(:name).titleize) if self.send(:name)
	  end
end

