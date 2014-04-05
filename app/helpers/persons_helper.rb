# encoding: UTF-8
module PersonsHelper
  
  def manager
    current_user.admin? || current_user.facilitator? || current_user.coordinator?
  end

  def current_group(person)
    current = false
    person.groups.each { |g| current = true if g.finish_date.past? }
    current
  end

  # Balance for a group
  def total_balance(group)
  	balance = 0
  	group.spots.each { |s| balance += s.balance }
  	balance
  end

  # Methods for groups and persons

  def total_payments(model)
  	total = 0
  	model.payments.each { |p| total += p.amount }
  	total
  end

  def total_scholarship(model)
  	total = 0
  	model.payments.where(:scholarship => true).each { |p| total += p.amount }
  	total
  end

end