Rails.application.routes.draw do
  root to: 'top#index'
  get 'results/index'
end
