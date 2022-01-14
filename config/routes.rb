Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :periods do
    put :edit_name, action: :edit_name
    put :edit_times, action: :edit_times
  end
end
