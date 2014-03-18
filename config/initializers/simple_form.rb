SimpleForm.setup do |config|
  inputs = %w[
	  CollectionSelectInput
	  DateTimeInput
	  NumericInput
	  PasswordInput
	  RangeInput
	  StringInput
	  TextInput
	]
	 
	inputs.each do |input_type|
	  superclass = "SimpleForm::Inputs::#{input_type}".constantize
	 
	  new_class = Class.new(superclass) do
	    def input_html_classes
	      super.push('form-control')
	    end
	  end
	 
	  Object.const_set(input_type, new_class)
	end

  config.button_class = 'btn btn-sm btn-primary'
  # config.input_class = "form-control"
end