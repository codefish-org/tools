# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  get 'base64', to: 'pages#base64'
  post 'base64', to: 'pages#base64'

  root 'pages#home'
end
