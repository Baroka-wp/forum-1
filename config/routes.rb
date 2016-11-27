Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "topics#index"

  resources :users do 
    resources :favorites , :controller => "user_favorites"
  	resources :topics
    collection do
        get :profile
        get :favorite
        get :like
        get :draft
        patch :update_draft
    end
  end


  resources :topics do
  	resources :comments , :controller => "topic_comments"
  	collection do
      get :about 
    end

    member do 
      post :favorite
      post :like
      post :subscribe
      post :create_tag
    end
  end

  namespace :admin do
    resources :topics 
    resources :users
    resources :categories
  end

end
