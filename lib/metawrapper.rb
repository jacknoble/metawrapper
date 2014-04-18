module Metawrapper

	def self.included(base)
		base.send(:include, InstanceMethods)
		base.extend(ClassMethods)
	end

	module InstanceMethods

		def method_missing(method_name, *args, &blk)
			variable_found = false
			wrapped_variables.each do |var|
				if variable_responds_to_method?(var, method_name)
					variable_found = true
					return get_ivar(var).send(method_name, *args, &blk)
				end
			end
			super unless variable_found
		end

		def wrapped_variables
			self.class.instance_variable_get(:@wrapped_variables)
		end

		def get_ivar(var)
			instance_variable_get('@' + var.to_s)
		end
 

		def variable_responds_to_method?(var, method)
			instance_variable_get('@'+ var.to_s).respond_to?(method)
		end


	end

	module ClassMethods

		def attr_wrapper(var_to_methods_hash)
			wrapped_variables = var_to_methods_hash.keys
			wrapped_variables.each do |var|
				methods = var_to_methods_hash[var]
				if methods == :all
					delegate_missing_methods_to_variable(var)
				else
					add_methods(var, methods)
				end
			end
		end

		def delegate_missing_methods_to_variable(var)
			@wrapped_variables ||= []
			@wrapped_variables << var
		end

		def unique_methods_for_variable_class(var)
			variable = instance_variable_get(var)
			variable.methods.select do |method|
				!self.instance_methods.include?(method)
			end
		end

		def add_methods(var, methods)
			methods.each do |method|
				define_method(method) do |*args, &prc|
					instance_variable_get('@'+ var.to_s).send(method, *args, &prc)
				end
			end
		end

	end

end