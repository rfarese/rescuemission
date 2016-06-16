Rails.application.routes.draw do
  root "questions#index"

  get '/auth/:provider/callback', to: 'sessions#create'

  resources :questions do
    resources :answers, only: [:create, :destroy]
  end
end
