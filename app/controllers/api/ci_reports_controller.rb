class Api::CiReportsController < Api::BaseController

  def update
    params[:reports].each do |xml|
      report = JunitReport.new(xml)
      if report.feature_id && feature = @project.features.where(:project_feature_id => report.feature_id).first
        feature.update_attributes(:test_report => xml,
                                  :num_tests => report.num_tests,
                                  :num_failures => report.num_failures)
      end
    end
    render :json => {:ok => true}
  end
end