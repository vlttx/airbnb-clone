Rails.application.routes.draw do

  
root to: 'pages#home'
  devise_for :users, 
  			 :path => '', 
  			 :path_names => {:sign_in => 'login', :sign_out => 'logout', :edit => 'profile'},
         :controllers => {omniauth_callbacks: 'users/omniauth_callbacks' , registrations: 'registrations'}
         
  			 # calling omniauth controller


  resources :users, only: [:show]
  resources :rooms
  resources :photos
  resources :rooms do 
    resources :reservations, only: [:create]
  end

  get '/preload' => 'reservations#preload'
  get '/preview' => 'reservations#preview'
  get '/your_trips' => 'reservations#your_trips'
  get '/your_reservations' => 'reservations#your_reservations '
  # we nest reservations under room because we need to know which room is being reserved
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end