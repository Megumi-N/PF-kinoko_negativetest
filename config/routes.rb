Rails.application.routes.draw do
  root to: 'top#index'
  get 'results/index'
  get '/tweet', to: 'twitter_analyses#twitter_analysis'
end
