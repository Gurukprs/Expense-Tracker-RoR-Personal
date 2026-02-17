Rails.application.routes.draw do
  get 'dashboard/index'
  devise_for :users
  root "dashboard#index"
  resources :money_cycles do
    resources :incomes, only: [:create]
    resources :expenses
    member do
      patch :close
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
