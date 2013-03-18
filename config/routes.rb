RailsSample::Application.routes.draw do
  root :to => 'home#index'
  
  resources :groups do
    resources :invitations
    post 'join', :on => :collection
  end
  
end