BabyRecord::Application.routes.draw do
  resources :events do
    collection do
      get 'report'
      get 'chart'
      get 'feedings'
      get 'wet_diapers'
      get 'dirty_diapers'
    end
  end
  root :to => 'events#index'
end
