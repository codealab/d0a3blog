class ActiveRecord::Base

  def can_destroy?
    self.class.reflect_on_all_associations.all? do |assoc|
      assoc.options[:dependent] != :restrict_with_error ||
      (assoc.macro == :has_one && self.send(assoc.name).nil?) || 
      (assoc.macro == :has_many && self.send(assoc.name).empty?)
    end
  end
  
  def have_dependencies?
    associations = false
    self.class.reflect_on_all_associations.each do |assoc|
      associations = true if (assoc.macro == :has_one && !self.send(assoc.name).nil?) || (assoc.macro == :has_many && !self.send(assoc.name).empty?)
      break if associations
    end
    associations
  end

  def remove(opts={})
    o = { :current_user => User.new }.merge(opts)
    self.destroy if o[:current_user].admin? || !self.have_dependencies?
  end

end