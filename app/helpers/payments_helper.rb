# encoding: UTF-8
module PaymentsHelper

  # Balance for a group and/or family
  def total_balance(model)
  	balance = 0
  	model.spots.each { |s| balance += s.balance }
  	balance
  end

  # Total cost for family and/or person
  def total_cost(model)
    cost = 0
    model.groups.each { |g| cost += g.cost }
    cost
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

  def payments_result(payments)
    total = 0
    payments.each { |p| total += p.amount }
    total
  end

  def negative_value(value)
    out_html = "$#{value}"
    out_html = "<span class='negative_payment'>$#{value.abs}</span>" if value<0
    out_html.html_safe
  end

end