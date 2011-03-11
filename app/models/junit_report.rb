class JunitReport

  attr_accessor :doc

  def initialize(xml)
    @doc = Nokogiri.XML(xml)
  end

  def feature_id
    doc.at("/testsuite").try(:[], "name").try(:match, /#(\d+)/).try(:[], 1).to_i
  end

  def num_tests
    doc.at("/testsuite").try(:[], "tests").to_i
  end

  def num_failures
    doc.at("/testsuite").try(:[], "errors").to_i + doc.at("/testsuite").try(:[], "failures").to_i
  end

  def scenarios
    doc.search("/testsuite/testcase").collect do |e|
      {:name => e["name"], :passed => e.search("./failure").empty?}
    end
  end
end