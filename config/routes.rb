Rails.application.routes.draw do
  devise_for :users

  resources :rooms do
    get 'start_broadcast'
    get 'join_broadcast'
    get 'disconnect'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'rooms#index'
end
