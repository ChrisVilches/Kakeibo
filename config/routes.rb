Rails.application.routes.draw do
  post '/graphql', to: 'graphql#execute'

  devise_for :users, skip: :all

  devise_scope :user do
    scope :users do
      post :sign_in, to: 'devise/sessions#create', as: :user_session
      delete :sign_out, to: 'devise/sessions#destroy', as: :destroy_user_session
      get :me, to: 'users/users#me'
    end
  end

  root 'home#index'
end
