class ProjectImagesController < ApplicationController
  before_action :require_admin

  def create
    @project = Project.find(params[:project_id])
    @project_image = @project.project_images.build(project_image_params)

    if @project_image.save
      redirect_to @project, notice: "Изображение добавлено"
    else
      redirect_to @project, alert: "Ошибка при добавлении изображения"
    end
  end

  def destroy
    @project_image = ProjectImage.find(params[:id])
    @project = @project_image.project
    @project_image.destroy
    redirect_to @project, notice: "Изображение удалено"
  end

  private

  def project_image_params
    params.require(:project_image).permit(:image, :position)
  end
end
