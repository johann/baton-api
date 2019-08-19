Rails.application.routes.draw do
  resources :activity_sessions
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # resources :clients
  
  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: { sessions: :sessions }, 
                        path_names: { sign_in: :login }
    resource :user, only: [:show, :update]
    resources :groups

    namespace :coach do
      resources :activity_categories
    end

    namespace :user do
      resources :groups, only: [:index, :create, :destroy]
    end
  end
end
