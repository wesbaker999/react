class GlossaryTermsController < ApplicationController
  before_filter :load_project
  before_filter :load_term

  before_filter do
    @tab="terms"
  end

  def index
    @terms = @project.glossary_terms.alphabetical
  end

  def new
     @term = @project.glossary_terms.new
  end

  def create
     @term = @project.glossary_terms.new(params[:glossary_term])
     if @term.save
       flash[:notice] = "Term created"
       redirect_to project_glossary_term_path(@project, @term) and return
     end
     render :action => :new
   end

  def edit

  end

  def update
    if @term.update_attributes(params[:glossary_term])
      flash[:notice] = "Term updated"
      redirect_to project_glossary_term_path(@project, @term) and return
    end
    render :action => :edit
  end

  def show

  end

  def destroy
    @term.destroy
    redirect_to :action => :index
  end

  private

  def load_term
    @term = GlossaryTerm.find(params[:id]) unless params[:id].blank?
    @meta_title << " - #{@term.name}" if @term
  end

  def load_project
    @project = Project.find(params[:project_id]) unless params[:project_id].blank?
    @membership = @project.memberships.for_user(current_user).first unless @project.blank?
    @meta_title << " - #{@project.name} - Glossary" if @project
  end
end