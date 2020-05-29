Rails.application.routes.draw do
  resources :cocktails, only: [:new, :create, :show, :index] do
    resources :doses, only: [:create]
    resources :reviews, only: [:create]

    collection do
      get :best
    end
  end
  resources :doses, only: [:destroy]

  get "/random", to: "cocktails#random", as: :random
  root to: 'cocktails#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
