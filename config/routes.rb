Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               sessions:      'users/sessions',
               registrations: 'users/registrations'
             }

  root 'home#index'

  resources :periods do
    put :edit_name, action: :edit_name
    put :edit_times, action: :edit_times
    # TODO: Maybe can be improved (e.g. remove "upsert" from URL).
    get ':day_date', controller: :days, action: :show
    put 'upsert_day/:day_date', controller: :days, action: :upsert_day
    put 'expenses/:day_date', controller: :expenses, action: :create
  end

  resources :expenses, only: %i[destroy]

  namespace :users do
    get :me
  end
end
