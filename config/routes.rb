Rails.application.routes.draw do
  get 'results/index'
  get '/', to: 'top#index'
end
