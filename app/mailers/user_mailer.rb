class UserMailer < ActionMailer::Base

  def empty_plans(lecture,user)
  	@name = user.name
  	@mail = user.email
  	@lecture = lecture
	mail(:from => 'contacto@deceroatres.com', :to => user.email, :subject => 'Recordatorio de Clase' )
  end

  def exercises_and_materials(lecture,user)
  	@name = user.name
  	@mail = user.email
  	@lecture = lecture
	mail(:from => 'contacto@deceroatres.com', :to => user.email, :subject => 'Recordatorio de Clase' )
  end

  def attendances_is_null(lecture,user)
  	@name = user.name
  	@mail = user.email
  	@lecture = lecture
	mail(:from => 'contacto@deceroatres.com', :to => user.email, :subject => 'Clase sin asistencia' )
  end

end