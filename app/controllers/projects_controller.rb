class ProjectsController < ApplicationController
  before_action :require_admin, except: [:index, :show]
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.recent.includes(:project_images, :project_links)
  end

  def show
    @images = @project.project_images.ordered
    @links = @project.project_links.ordered
  end

  def new
    @project = Project.new
    @project.project_links.build # Начинаем с одной пустой ссылки
  end

  def create
    @project = current_user.projects.build(project_params)

    if @project.save
      handle_image_uploads
      redirect_to @project, notice: "Проект успешно создан!"
    else
      render :new
    end
  end

  def edit
    @project.project_links.build if @project.project_links.empty?
  end

  def update
    if @project.update(project_params)
      handle_image_uploads
      redirect_to @project, notice: "Проект успешно обновлен!"
    else
      render :edit
    end
  end

  def destroy
    project_title = @project.title
    @project.destroy!
    respond_to do |format|
      format.html { redirect_to projects_path, notice: "Проект '#{project_title}' успешно удален" }
      format.json { head :no_content }
    end
  rescue ActiveRecord::RecordNotDestroyed => e
    respond_to do |format|
      format.html { redirect_to @project, alert: "Не удалось удалить проект: #{e.message}" }
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :detailed_description,
                                   :author_name, :technology_stack,
                                   project_links_attributes: [:id, :title, :url, :link_type, :icon, :position, :_destroy])
  end

  def handle_image_uploads
    return unless params[:project][:images]

    params[:project][:images].each_with_index do |image, index|
      next if image.blank?

      project_image = @project.project_images.build(position: index)
      project_image.image.attach(image)
      project_image.save
    end
  end
end
