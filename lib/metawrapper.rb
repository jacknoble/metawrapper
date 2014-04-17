module Metawrapper

	def method_missing (method_name, *args, &blk)
		variable_found = false
		instance_variables.each do |var|
			if variable_responds_to_method?(var, method_name)
				variable_found = true
				return instance_variable_get(var).send(method_name, *args, &blk)
			end
		end
		super unless variable_found
	end

	def variable_responds_to_method?(var, method)
		instance_variable_get(var).respond_to?(method)
	end

	


end