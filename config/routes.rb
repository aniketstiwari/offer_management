Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :offers, only: [], :defaults => { :format => 'json' } do
    post :get_best_deals, on: :collection
  end
end
