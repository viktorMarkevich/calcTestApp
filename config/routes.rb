Rails.application.routes.draw do

  resources :calcs, only: %i[index create]

  root to: 'calcs#index'
end
