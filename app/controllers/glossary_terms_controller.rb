class GlossaryTermsController < ApplicationController
  before_filter :load_project
  before_filter :load_term
  before_filter :require_membership

  def new
     @term = @project.glossary_terms.new
  end

  def create
     @term = @project.glossary_terms.new(params[:glossary_term])
     respond_to do |format|
       format.html{
         if @term.save
           flash[:notice] = t("txt.glossary.term_created")
           redirect_to project_glossary_term_path(@project, @term) and return
         end
         render :action => :new
        }
       format.js{
         @term.save
       }
     end
   end

  def edit
    render :layout => false
  end

  def update
    respond_to do |format|
      format.html {
        if @term.update_attributes(params[:glossary_term])
          flash[:notice] = t("txt.glossary.term_updated")
          redirect_to project_glossary_term_path(@project, @term) and return
        end
        render :action => :edit
      }
      format.js {
        @term.update_attributes(params[:glossary_term])
      }
    end
  end

  def destroy
    @term.destroy
    redirect_to :action => :index
  end

  private

  def load_term
    @term = GlossaryTerm.find(params[:id]) unless params[:id].blank?
    @meta_title << @term.name if @term
  end

  def load_project
    @project = Project.find(params[:project_id]) unless params[:project_id].blank?
    render_not_found and return unless @project
    @membership = @project.memberships.for_user(current_user).first
    if @project
      @meta_title << t("txt.glossary.glossary")
      @meta_title << @project.name
    end
  end
end