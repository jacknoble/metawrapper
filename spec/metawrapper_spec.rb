require 'spec_helper'

describe 'with a single collection variable' do 
	it 'runs enum methods on instance variable' do
		test_instance = TestWithCollection.new
		test_instance.stuff.should eq([1,2,3,4,5])	
		max = test_instance.max
		max.should eq(5)
	end
end

