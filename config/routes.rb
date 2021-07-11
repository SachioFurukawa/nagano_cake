Rails.application.routes.draw do

  #root "public/homes#top"
  root "public/items#top"
  get "admin_other", to: "admin_other/orders#index"

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
  end

  devise_for :admins, :controllers => {
    :sessions => 'admins/sessions'
  }

  scope module: :public do
    #root "top#index"
    get "homes/about" => "homes#about",as:"about"
    resources :items, only: [:show,:index]
    resources :addresses, only: [:create,:destroy,:update,:index,:edit]
    resources :cart_items, only: [:index,:create,:update,:destroy] do
      collection do
        delete "destroy_all"
      end
    end
    resources :orders, only: [:new,:create,:index,:show] do
      collection do
        post "confirm"
        get "complete"
      end
    end

    resources :users, only: [:show,:index,:edit,:update]
    #put "/users/:id/unsubscribe" => "users#unsubscribe",as:"users_unsubscribe"
    #patch "/users/withdraw", "users#withdraw"
    get 'unsubscribe/:name' => 'users#unsubscribe', as: 'confirm_unsubscribe'
    patch ':id/withdraw/:name' => 'users#withdraw', as: 'withdraw_user'
    put 'withdraw/:name' => 'users#withdraw'
  end

  namespace :admin_other do
    resources :orders, only: [:index,:show,:update]
    resources :items, only: [:index,:create,:new,:show,:update,:edit]
    resources :users, only: [:show,:edit,:update,:index]
    resources :order_details, only: [:update]
    resources :genres, only: [:index,:create,:edit,:update]
  end

end