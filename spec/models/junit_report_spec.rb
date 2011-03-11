require File.expand_path("#{File.dirname(__FILE__)}/../spec_helper")

describe JunitReport do

  context "passing report" do
    before do
      @report = JunitReport.new(File.read("#{Rails.root}/spec/support/TEST-projects.xml"))
    end

    it "should have a feature id" do
      @report.feature_id.should == 2
    end

    it "should have num_tests" do
      @report.num_tests.should == 2
    end

    it "should have num_failures" do
      @report.num_failures.should == 0
    end

    it "should have scenarios" do
      @report.scenarios.should == [{:name => "Create a project", :passed => true}, {:name => "Edit project name", :passed => true}]
    end
  end

  context "failing report" do
    before do
      @report = JunitReport.new(File.read("#{Rails.root}/spec/support/TEST-sign_up-failed.xml"))
    end

    it "should have a feature id" do
      @report.feature_id.should == 1
    end

    it "should have num_tests" do
      @report.num_tests.should == 2
    end

    it "should have num_failures" do
      @report.num_failures.should == 1
    end

    it "should have scenarios" do
      @report.scenarios.should == [{:name => "Successful sign up", :passed => false}, {:name => "Unsuccessful sign up", :passed => true}]
    end
  end
end
