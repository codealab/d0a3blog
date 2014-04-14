# encoding: UTF-8
module PersonsHelper
  
  def manager
    current_user.admin? || current_user.facilitator? || current_user.coordinator?
  end

  def current_group(person)
    current = false
    person.groups.each { |g| current = true if !g.finish_date.past? }
    current
  end

end