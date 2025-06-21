class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password]) && user.admin?
      session[:user_id] = user.id
      redirect_to root_path, notice: "Добро пожаловать!"
    else
      flash.now[:alert] = "Неверные данные или недостаточно прав"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Вы вышли из системы" }
      format.json { head :no_content }
    end
  end
end
