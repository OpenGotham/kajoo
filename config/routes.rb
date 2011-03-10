FixIt::Application.routes.draw do
  
  resources :issues do 
    resources :solutions
    #disabled for now
    #match 'solutions/:id/vote' => 'solutions#vote', :as => 'vote_for_solution'
    #resources :comments
  end

  match 'issues/:id/vote' => 'issues#vote', :as => 'vote_for_issue'

  resources :reports

  match 'index' => "pages#index", :as => 'index'
  match 'dashboard' => 'pages#dashboard', :as => 'dashboard'
  match 'home' => 'pages#home', :as => 'home'
  match 'contact' => 'pages#contact', :as => 'contact'
  match 'about' => 'pages#about', :as => 'about'

  resources :users
  get "users/dashboard"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "pages#index"

end
