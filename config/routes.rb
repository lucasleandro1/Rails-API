Rails.application.routes.draw do

  resources :auths, only: [:create]
  resources :kinds
  
  scope module: "v1" do
    resources :contacts, :constraints => lambda {|request| request.params[:version] == "1"} do
      resource :kind, only: [:show]
      resource :kind, only: [:show], patch: 'relationships/kind'

      resource :phones, only: [:show]
      resource :phones, only: [:show], patch: 'relationships/phones'

      resource :address, only: [:show, :update, :create, :destroy]
      resource :address, only: [:show, :update, :create, :destroy], patch: 'relationships/address'
    end
  end

  scope module: "v2" do
    resources :contacts, :constraints => lambda {|request| request.params[:version] == "2"}do
      resource :kind, only: [:show]
      resource :kind, only: [:show], patch: 'relationships/kind'

      resource :phones, only: [:show]
      resource :phones, only: [:show], patch: 'relationships/phones'

      resource :address, only: [:show, :update, :create, :destroy]
      resource :address, only: [:show, :update, :create, :destroy], patch: 'relationships/address'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
