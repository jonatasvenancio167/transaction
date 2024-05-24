Rails.application.routes.draw do
  resources :accounts, path: 'conta', only: [:create, :show] do
    collection do
      get :find_by_account_number
    end
  end

  resources :amount_transactions, path: 'transacao', only: [:create]
end
