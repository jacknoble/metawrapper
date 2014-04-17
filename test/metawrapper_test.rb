require_relative '../lib/metawrapper.rb'
class TestWithCollection
	# include Metawrapper
	include Enumerable
	attr_reader :stuff

	def initialize
		@stuff = [1,2,3,4,5, 6]
	end

	def each(&prc)
		@stuff.each(&prc)
	end

end

t = TestWithCollection.new
# t.each do |el|
# 	puts el
# end

t[3]

