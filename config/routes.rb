Rails.application.routes.draw do
  #get 'sessions/new'
  #get 'sessions/create'
  get 'sessions/destory'
  get 'users/price'
  post 'users/price'
  get 'users/draw'
  post 'users/draw'
  
  resources :users
  #resources :sessions
 
  resources :sessions #,only [:new,:create,:destory]
  #post 'sessions/create ' ,to 'sessions#create'
   root to:'sessions#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
