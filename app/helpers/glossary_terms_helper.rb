module GlossaryTermsHelper
  def link_feature_terms(feature)
    link_feature_terms_by_string(feature.description, feature.project)
  end

  def link_feature_terms_by_string(string, project)
    output = project.glossary_terms.inject(string) do |result, t|
      result.gsub(/#{t.name}/, link_to(t.name, project_glossary_term_path(project, t), :title => t.definition, :class => "term"))
    end
    output = project.actors.inject(output) do |result, a|
      result.gsub(/#{a.name}/, link_to(a.name, project_actor_path(project, a), :title => a.description, :class => "term"))
    end
    output.gsub!(/#(\d+)/){ link_to("##{$1}", project_feature_path(project, $1), :class => "term") }
    output
  end
end