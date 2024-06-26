Rails.application.routes.draw do
  get 'article_query_logs/create'
  get 'article_query_logs/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  resources :article_query_logs, only: [:create, :index]
  get 'dashboard', to: 'ranking_words#index'
  get '/', to: 'article_query_logs#index'
  post 'query', to: 'article_query_logs#create'
end
