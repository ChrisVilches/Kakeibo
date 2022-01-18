Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: 'graphql#execute'
  end

  post '/graphql', to: 'graphql#execute'

  devise_for :users,
             controllers: {
               sessions:      'users/sessions',
               registrations: 'users/registrations'
             }

  root 'home#index'

  namespace :users do
    get :me
  end
end
