DealsOffer::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  scope "/gwu" do
    resources :calendar
    
    resources :home do
      collection { match 'reset_password'
                   match 'reset'}
    end

    devise_for :users , :controllers => {:registrations => "users/registrations"}

    devise_scope :user do
      get "sign_in", :to => "devise/sessions#new" , :as => 'login'
      get "sign_up", :to => "devise/registrations#new" , :as =>  'sign_up'
      get "logout" => 'devise/sessions#destroy'
    end
    
    namespace :admin do
       root :to => 'home#index' , :prefix => 'admin'
       
       resources :home do
         collection  { match 'invite'}
       end
       
       resources :users
       resources :teams
    end

    namespace :students do
      match 'index',   :action => 'index'
      
      resources :events do
        collection {
          match 'events_showall'
          match 'events_search',  :via => :get
          match 'events_index',   :via => :get
        }
      end
      resources :courses do
        collection {
          match 'courses_index',   :via => :get
          match 'courses_showall' 
          match 'courses_search',  :via => :get
          match 'course_assign',   :via => :get
          match 'course_unassign', :via => :get
        }
      end
    end
    
    namespace :coaches do
      match 'my_team', :action => "my_team"
      match 'index',   :action => 'index'
      
      resources :events do
        collection { 
          match 'events_showall', :via => :get
          match 'events_search',  :via => :get
          match 'events_index',   :via => :get
        }
      end
    end
    
    root :to => 'home#index'
    
    match '/users/profile',                :to => 'users/profile#index'
    match '/users/profile/create'  ,       :to => 'users/profile#create'
    match '/users/profile/update'  ,       :to => 'users/profile#update'
    match '/users/profile/show'  ,         :to => 'users/profile#show'
    
    match '/home/reset_password'  ,        :to => 'home#reset_password'

  end
  
  #routings error
  match '*a', :to => 'errors#routing'
end
