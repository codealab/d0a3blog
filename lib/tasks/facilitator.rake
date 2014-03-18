namespace :facilitator do
  desc "If have a class tomorrow"
  task mailing: :environment do
  	lectures = Lecture.where('date > ? AND date < ?', Date.today, Date.tomorrow+1.day)
  	lectures.each do |l|
  		user = l.group.user
  		puts '========================='
  		puts "el mail se está enviando a #{user.name}"
  		UserMailer.user_added(user).deliver
  	end
  end
end