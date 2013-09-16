BabyRecord::Application.routes.draw do
  resources :events do
    collection do
      get 'report'
      get 'chart'
      get 'feeding'
      get 'diaper'
    end
  end
  root :to => 'events#index'
end
