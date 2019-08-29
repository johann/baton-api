Rails.application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # resources :clients
  
  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: { sessions: :sessions }, 
                        path_names: { sign_in: :login }
    resource :user, only: [:show, :update]
    # resources :groups

    resources :groups do
      resources :activities
    end

    # resources :activity_sessions

    namespace :user do
      resources :groups, only: [:index, :create, :destroy]
      resources :activities
    end
  end
end
