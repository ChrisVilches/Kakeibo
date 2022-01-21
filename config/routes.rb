Rails.application.routes.draw do
  post '/graphql', to: 'graphql#execute'

  devise_for :users,
             controllers: {
               sessions: 'users/sessions'
               # registrations: 'users/registrations'
             }

  root 'home#index'

  scope module: :users do
    namespace :users do
      get :me
    end
  end
end
