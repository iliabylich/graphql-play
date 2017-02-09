Rails.application.routes.draw do
  namespace :api do
    post '/graph', to: 'graphql#run'
    get  '/docs',  to: 'graphql#docs'
  end
end
