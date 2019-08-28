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
      resources :activities do
        resources :activity_sessions
      end
    end

    # resources :activity_sessions

    namespace :user do
      resources :groups, only: [:index, :create, :destroy]
      resources :activities, only: [:index]
    end
  end
end
