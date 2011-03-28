module GlossaryTermsHelper
  def link_feature_terms(feature)
    link_feature_terms_by_string(feature.description, feature.project)
  end

  def link_feature_terms_by_string(string, project)
    output = project.glossary_terms.inject(string) do |result, t|
      result
        .gsub(/#{t.name}/, content_tag(:span, :class=>"term_container"){ content_tag(:span, :class=>"term"){t.name} + content_tag(:span, :class=>"tip"){t.definition}})
        .gsub(/#{t.name.downcase}/, content_tag(:span, :class=>"term_container"){ content_tag(:span, :class=>"term"){t.name.downcase} + content_tag(:span, :class=>"tip"){t.definition}})
    end
    output = project.actors.inject(output) do |result, a|
      result.gsub(/#{a.name}/, link_to(a.name, project_features_path(project, :actor_id => a.id), :title => a.name))
    end
    output.gsub!(/#(\d+)/){ link_to("##{$1}", project_feature_path(project, $1), :class => "term") }
    output
  end
end