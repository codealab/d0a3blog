class UserMailer < ActionMailer::Base
  def user_added(user,lecture)
  	@name = user.name
  	@mail = user.email
  	@lecture = lecture
	mail(:from => 'contacto@deceroatres.com', :to => user.email, :subject => 'Recordatorio de Clase' )
  end
end