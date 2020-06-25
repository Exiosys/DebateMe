Rails.application.routes.draw do
  get '/ping' => 'test#ping'

  resources :users
  resources :posts

  resources :themes do
    resources :questions
  end
  resources :reports

  post '/auth/login' => 'authentication#authenticate'
  post '/auth/register'   => 'users#create'

  get '/users/search/:search' => 'users#search'
  get '/users/me/profile' => 'users#show_me'

  get '/users/:user_id/posts' => 'posts#search_index'
  get '/users/:user_id/posts/:id' => 'posts#search_show'
  delete '/users/:user_id/post/:id' => 'posts#search_destroy'

  get '/questions/:id/posts' => 'questions#get_posts'

  get '/reports_reasons' => 'reports#get_reasons'

  get '/posts/:id/vote' => 'posts#vote'

end