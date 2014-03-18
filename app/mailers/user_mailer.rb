class UserMailer < ActionMailer::Base
  def user_added(user)
  	@name = user.name
  	@mail = user.email
	mail(:from => 'contacto@deceroatres.com', :to => user.email, :subject => 'Recordatorio de Clase' )
  end
end