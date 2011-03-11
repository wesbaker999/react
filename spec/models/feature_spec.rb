require File.expand_path("#{File.dirname(__FILE__)}/../spec_helper")

describe Feature do

  it "should be passed" do
    @feature = Feature.new(:num_tests => 3, :num_failures => 0)
    @feature.should be_passed
  end

  it "should be failed" do
    @feature = Feature.new(:num_tests => 3, :num_failures => 1)
    @feature.should be_failed
  end

  it "should be unimplemented" do
    @feature = Feature.new(:num_tests => 0, :num_failures => 0)
    @feature.should be_unimplemented
  end
end
