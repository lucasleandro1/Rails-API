Rails.application.routes.draw do
  resources :kinds

  resources :contacts do
    resource :kind, only: [:show]
    resource :kind, only: [:show], patch: 'relationships/kind'

    resource :phones, only: [:show]
    resource :phones, only: [:show], patch: 'relationships/phones'

    resource :address, only: [:show]
    resource :address, only: [:show], patch: 'relationships/address'
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
