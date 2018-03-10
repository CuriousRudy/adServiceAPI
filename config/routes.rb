Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :advertisers
      resources :products
      post '/more', to: 'products#more'
    end
  end
end
