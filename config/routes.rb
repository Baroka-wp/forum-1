Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "topics#index"

  resources :users do 
    resources :friendships , :controller => "user_friendships" do
      collection do 
        get :friend_request
        get :friendship
        post :invite_friendship
        post :accept_friendship
        post :refuse_friendship
      end
    end
    resources :favorites , :controller => "user_favorites"
  	resources :topics
    collection do
        get :favorite
        get :like
        get :draft
        patch :update_draft
        get :profile , param: :useremail # XXX
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

  namespace :api , path: '' do
    # constraints(host: 'api-example.com') do

    # end
  end


  namespace :api do
    resources :users
    get '*unmatched_route', to: 'base#page_404'
  end

  namespace :test do
    resources :users
    get '*unmatched_route', to: 'base#page_404'
  end
end

