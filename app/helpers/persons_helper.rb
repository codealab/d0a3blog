# encoding: UTF-8
module PersonsHelper

  def manager
    current_user.admin? || current_user.instructor? || current_user.coordinator?
  end

  def current_group(person)
    current = false
    person.groups.each { |g| current = true if !g.finish_date.past? }
    current
  end

  def attendance_percent(person)
    lectures = person.lectures.where("date <= ? AND date >= ?", Date.today.to_datetime+1, person.created_at.to_datetime ).count
    attendances = person.attendances.count
    if lectures==0
      percent = "ND"
    else
      percent = "#{(attendances*100)/lectures}%"
    end
    percent
  end

  def age_average(group)
    childs = group.childs
    if childs.empty?
      "N/D"
    else
      age_array = childs.map(&:dob_to_weeks_float)
      average = age_array.inject{ |sum, el| sum + el }
      "#{((average/childs.count).to_f).round(2)} semanas"
    end
  end

end