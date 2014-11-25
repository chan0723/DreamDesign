Rails.application.routes.draw do

  root 'static_pages#home'
  get 'general/ranking'
  get 'general/hot_ranking'

  resources :schools
  
  resources :my_schools, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  
  resources :schools do
    resources :reviews
  end

  get 'static_pages/home'
  get 'static_pages/help'
  get 'mylist' => 'users#mylist'
  get 'allschools' => 'schools#index'
  post 'addSchool' => 'my_schools#addSchool'
  

  devise_for :users, :controllers => {:registrations => "users/registrations", :omniauth_callbacks => "users/omniauth_callbacks"} do
    get 'sign_out' => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  
 resource :users, :only => [:index, :show] do
   member do
     get :following, :followers
   end
 end
  

  get '/general/ranking'=>'general#ranking'
  get '/general/index'=>'general#index'
  
  
  
 
  resources :general do
    collection { post :import }
  end
  
  get 'index'=>'general#index'
  
  get 'general/add_following'
  
end
