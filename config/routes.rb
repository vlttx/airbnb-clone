Rails.application.routes.draw do

  root to: 'pages#home'

  devise_for :users, 
  			 :path => '', 
  			 :path_names => {:sign_in => 'login', :sign_out => 'logout', :edit => 'profile'},
  			 :controllers => {:omniauth_callbacks  => 'callbacks',
  			 	:registrations => 'registrations'}
  			 # calling omniauth controller

  resources :users, only: [:show]
  resources :rooms
  resources :photos
  resources :rooms do 
    resources :reservations, only: [:create]
  end

  get '/preload' => 'reservations#preload'
  get '/preview' => 'reservations#preview'
  # we nest reservations under room because we need to know which room is being reserved
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
