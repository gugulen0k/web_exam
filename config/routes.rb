Rails.application.routes.draw do
  root "projects#index"

  # Аутентификация
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # Проекты
  resources :projects do
    resources :project_images, only: [ :create, :destroy ]
  end

  # Здоровье приложения
  get "up" => "rails/health#show", as: :rails_health_check
end
