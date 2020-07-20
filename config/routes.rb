Rails.application.routes.draw do
  resources :calcs

  root to: 'calcs#index'
end
