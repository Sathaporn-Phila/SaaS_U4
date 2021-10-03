Myrottenpotatoes::Application.routes.draw do
  resources :movies do
    resources :reviews
  end
  root :to => redirect('/movies')
  post '/search_tmdb',to: 'movies#search_tmdb'
  get '/set_movie_object',to: 'movies#set_movie_from_result'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'logout', to: 'users/omniauth_callbacks#destroy'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
