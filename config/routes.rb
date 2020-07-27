Rails.application.routes.draw do
  root "pages#home"
  get 'pages/home', to: 'pages#home'

  # get '/recipes', to: 'recipes#index'
  # get 'recipes/new', to: 'recipes#new', as: 'new_recipe'
  # get 'recipes/:id', to: 'recipes#show', as: 'recipe'
  # I can use resource for this, so I do that
  resources :recipes

  get '/signup', to: 'chefs#new'
  resources :chefs, except: [:new]

end
