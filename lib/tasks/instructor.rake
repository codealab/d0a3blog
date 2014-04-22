namespace :instructor do
  
  desc "Empty plans in lecture"
  task empty_plans: :environment do
  	lectures = Lecture.where('date >= ? AND date < ?', Date.tomorrow.to_datetime, Date.tomorrow.to_datetime+1)
  	lectures.each do |lecture|
  		UserMailer.empty_plans(lecture).deliver
      if !lecture.group.assistant.blank?
        puts "enviando un mail a facilitador"
        user = lecture.group.assistant
        UserMailer.empty_plans(lecture,user).deliver
      end
  	end
  end

  desc "Exercises and materials for lecture today's"
  task exercises_and_materials: :environment do
  	lectures = Lecture.where('date >= ? AND date < ?', Date.today.to_datetime, Date.tomorrow.to_datetime+1)
  	lectures.each do |lecture|
  		UserMailer.exercises_and_materials(lecture).deliver
      if !lecture.group.assistant.blank?
        puts "enviando un mail a facilitador"
        user = lecture.group.assistant
        UserMailer.exercises_and_materials(lecture,user).deliver
      end
  	end
  end

  desc "If attendances in lecture is null"
  task attendances_is_null: :environment do
    lectures = Lecture.where("date >= ? AND date < ?", Date.today.to_datetime-30, Date.today.to_datetime).where("id not in (select lecture_id from attendances)")
  	lectures.each do |lecture|
      user = lecture.group.user
  		UserMailer.attendances_is_null(lecture,user).deliver
      if !lecture.group.assistant.blank?
        puts "enviando un mail a facilitador"
        user = lecture.group.assistant
        UserMailer.attendances_is_null(lecture,user).deliver
      end
  	end
  end

end