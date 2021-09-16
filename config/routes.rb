Rails.application.routes.draw do

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: { sessions: :sessions },
                        path_names: { sign_in: :login }
    resource :user, only: [:show, :update]
    get "users/:user_id", to: "users#username" # remove
    post "users/facebook", to: "users#facebook"

    get "activities/discover", to: "activities#discover"
    get "activities/search", to: "activities#search"
    get "activities/:id", to: "activities#show"
    get "activities/:id/members", to: "activities#members"
    get "groups/discover", to: "groups#discover"
    get "coaches/discover", to: "coaches#discover"

    post 'password/forgot', to: 'passwords#forgot'
    post 'password/reset', to: 'passwords#reset'

    resources :groups do
      resources :activities do
        get "/attendance", to: "attendances#show"
      end
      get "/members", to: "groups#members"
    end

    namespace :coach do
      resources :groups
    end

    resources :coaches do
      resources :activities, controller: "coaches/activities"
    end

    resources :users, param: :id do
      member do
        resources :groups, controller: "users/groups"
        resources :activities, controller: "users/activities"
      end
    end

    namespace :user do
      resources :groups, only: [:index, :create, :destroy]
      resources :activities
    end
  end

  namespace :share do
    resources :activities, only: [:show]
  end
end
