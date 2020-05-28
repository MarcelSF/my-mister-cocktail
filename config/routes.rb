Rails.application.routes.draw do
  resources :cocktails, only: [:new, :create, :show, :index] do
    resources :doses, only: [:create]
  end
  resources :doses, only: [:destroy]

  root to: 'cocktails#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
