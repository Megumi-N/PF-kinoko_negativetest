Rails.application.routes.draw do
  root to: 'top#index'
  get 'results/index'

  match '*path' => 'application#render_404', via: :all
  # post 'results/index', to: 'results#twitter_analysis'
  # post 'results/twitter_analysis', to: 'results#twitter_analysis'
  # get '/tweet', to: 'twitter_analyses#twitter_analysis'
end