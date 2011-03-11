require File.expand_path("#{File.dirname(__FILE__)}/../../spec_helper")

describe Api::CiReportsController do

  before do
    @project = Factory.create(:project)
    @actor = Factory.create(:actor)
    @feature1 = @project.features.create(:project_feature_id => 1, :actor => @actor, :title => "comments", :description => "i want to leave comments")
    @feature2 = @project.features.create(:project_feature_id => 2, :actor => @actor, :title => "uploads", :description => "i want to upload files")
    @reports = Dir.glob(File.join(Rails.root, "spec", "support", "TEST-{projects,sign_up}.xml")).collect do |f|
      File.read(f)
    end
  end

  it "should render unauthorized for invalid api key" do
    put :update, :api_key => "garbage"
    response.should_not be_success
    response.status.should == 401
  end

  it "should save test reports on features" do
    put :update, :api_key => @project.api_key, :reports => @reports
    response.should be_success

    @feature1.reload
    @feature1.test_report.should_not be_nil
    @feature1.num_tests.should == 2
    @feature1.num_failures.should == 0
    @feature2.reload
    @feature2.test_report.should_not be_nil
    @feature2.num_tests.should == 2
    @feature2.num_failures.should == 0
  end

  it "should ignore test reports without matching features" do
    @feature2.destroy
    put :update, :api_key => @project.api_key, :reports => @reports
    response.should be_success

    @feature1.reload
    @feature1.test_report.should_not be_nil
  end

  it "should ignore malformed xml" do
    put :update, :api_key => @project.api_key, :reports => ["sadfasdfasdf"]
    response.should be_success

    @feature1.reload
    @feature1.test_report.should be_nil
    @feature2.reload
    @feature2.test_report.should be_nil
  end

  it "should set num tests and failures for failed tests" do
    put :update, :api_key => @project.api_key, :reports => [File.read(File.join(Rails.root, "spec", "support", "TEST-sign_up-failed.xml"))]
    response.should be_success

    @feature1.reload
    @feature1.test_report.should_not be_nil
    @feature1.num_tests.should == 2
    @feature1.num_failures.should == 1
  end
end
