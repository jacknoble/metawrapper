# require 'bundler/setup'
# Bundler.setup

require_relative '../lib/metawrapper.rb'

class TestWithCollection
	include Metawrapper

	attr_reader :stuff

	def initialize
		@stuff = [1,2,3,4,5]
	end
end

# RSpec.configure do |config|
#   # some (optional) config here
# end