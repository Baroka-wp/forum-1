Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "topics#index"

  resources :users do 
    resources :favorites , :controller => "user_favorites"
  	resources :topics
    collection do
        get :profile
        get :favorite
        get :draft
        patch :update_draft
    end
  end


  resources :topics do
  	resources :comments , :controller => "topic_comments"
  	collection do
        get :about 
    end
  end

  namespace :admin do
    resources :topics 
    resources :users
    resources :categories
  end




end
