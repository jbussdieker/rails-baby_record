BabyRecord::Application.routes.draw do
  resources :events do
    collection do
      get 'report'
    end
  end
  root :to => 'events#index'
end
