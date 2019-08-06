Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # resources :clients
  
  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: { sessions: :sessions }, 
                        path_names: { sign_in: :login }
    resource :user, only: [:show, :update]
    resources :memberships
    resources :groups
  end
end
