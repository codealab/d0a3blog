# encoding: UTF-8
module ButtonsHelper

  $path = nil
  $model = nil
  $action = nil
  $link_attributes = nil

  def link_factory( options = { :_path => root_path, :_text => 'Home', :_class => '', :_button => true, :_remote => false, :_destroy => false, :_alert => 'Estás seguro?' } )
	$link_attributes = " href='#{options[:_path]}' "
	$link_attributes += " data-remote='true' " if options[:_remote]

	#user can enter to path?	
	auth = user_root_auth?(options[:_path])
	link_content = options[:_text]
	if auth
		link_content = "<p><button type='button' class='"+options[:_class]+"'>"+options[:_text]+"</button></p>" if options[:_button]
	else
		link_content = "<p><button type='button' class='"+options[:_class]+" disabled'>"+options[:_text]+"</button></p>" if options[:_button]
	end
	
	if options[:_destroy]
		object = $model.find($path[:id]) if $path[:id]
		$link_attributes += can_delete(object,options[:_alert]) if options[:_alert]
	end
	
	_html = "<a "+$link_attributes+">"+link_content+"</a>" #link_button
	_html.html_safe #return button
  end

  def user_root_auth?(_path)

	$path = Rails.application.routes.recognize_path("#{_path}")
	$action = $path[:action].parameterize.underscore.to_sym
	if $path[:controller] != 'password_reset'
		$model = $path[:controller].singularize.titleize.constantize
	end  	
  	false
  	true if can? $action, $model

  end
  
  def can_delete( object, alert )

  	if object.can_destroy?
  		" data-method='delete' data-confirm='¿Estás seguro?' " 
  	else
  		" class='disabled' data-method='delete' data-confirm='"+alert+"' "
  	end

  end

end