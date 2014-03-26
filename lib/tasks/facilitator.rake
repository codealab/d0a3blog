namespace :facilitator do
  desc "If have a class tomorrow"
  task mailing: :environment do
  	lectures = Lecture.where('date > ? AND date < ?', Date.today, Date.tomorrow+1.day)
  	lectures.each do |lecture|
  		UserMailer.user_added(user,lecture).deliver
  	end
  end
end