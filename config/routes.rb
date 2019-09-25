Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # resources :clients

  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: { sessions: :sessions },
                        path_names: { sign_in: :login }
    resource :user, only: [:show, :update]
    get "users/:username", to: "users#username"

    resources :groups do
      resources :activities do
        get "/attendance", to: "attendances#show"
      end
      get "/members", to: "groups#members"
    end

    # resources :activity_sessions
    namespace :coach do
      resources :groups
    end

    resources :users, param: :username do
      member do
        resources :groups, controller: "users/groups"
        resources :activities, controller: "user/activities"
      end
    end


    namespace :user do
      resources :groups, only: [:index, :create, :destroy]
      resources :activities
    end
  end
end
