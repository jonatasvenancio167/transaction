Rails.application.routes.draw do
  resources :accounts, path: 'conta', only: [:create]
  get '/conta', to: 'accounts#show'
  resources :amount_transactions, path: 'transacao', only: [:create]
end
