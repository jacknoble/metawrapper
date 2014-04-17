module Metawrapper

	def self.included(base)
		base.send(:include, InstanceMethods)
		base.extend(ClassMethods)
	end

	module InstanceMethods

		def method_missing(method_name, *args, &blk)
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

	module ClassMethods

		def attr_wrapper(var_to_methods_hash)
			wrapped_variables = var_to_methods_hash.keys
			wrapped_variables.each do |var|
				methods = var_to_methods_hash[var]
				methods = unique_methods_for_variable(var) if methods == :every
				add_methods(var, methods)
			end
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