BabyRecord::Application.routes.draw do
  resources :events do
    collection do
      get 'report'
      get 'chart'
    end
  end
  root :to => 'events#index'
end
