require_relative '../lib/metawrapper.rb'
class TestWithCollection
	include Metawrapper
	# include Enumerable
	attr_reader :stuff
	attr_wrapper :stuff => :all

	def initialize
		@stuff = [1,2,3,4,5, 6]
		@other_stuff = {test: "hash is working"}
	end

	# def each(&prc)
	# 	@stuff.each(&prc)
	# end

end

t = TestWithCollection.new
t.each do |el|
	puts el
end

# puts t
print t.max
