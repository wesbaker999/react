class Api::CiReportsController < Api::BaseController

  def update
    params[:reports].each do |report|
      doc = Nokogiri.XML(report)
      id = doc.at("/testsuite").try(:[], "name").try(:match, /#(\d+).*/).try(:[], 1)
      if id && feature = @project.features.where(:project_feature_id => id).first
        feature.update_attributes(:test_report => report)
      end
    end
    render :json => {:ok => true}
  end
end