Rails.application.routes.draw do
  root "questions#index"

  get '/auth/:provider/callback', to: 'sessions#create'

  get '/sign_out', to: 'sessions#sign_out'

  resources :questions do
    resources :answers, only: [:create, :destroy, :update]
  end
end
