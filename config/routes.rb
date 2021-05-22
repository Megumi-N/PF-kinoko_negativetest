Rails.application.routes.draw do
  root to: 'top#index'
  get 'results/index'
  # post 'results/index', to: 'results#twitter_analysis'
  # post 'results/twitter_analysis', to: 'results#twitter_analysis'
  # get '/tweet', to: 'twitter_analyses#twitter_analysis'
end
