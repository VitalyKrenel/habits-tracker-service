Rails.application.routes.draw do
  scope 'api' do
    resources :users
    resources :habits

    post 'habits/:id/set_stats', to: 'habit_stats#set'

    scope 'profile' do
      get '/', to: 'profile#me'
      put '/', to: 'profile#edit'
      post 'auth', to: 'profile#auth'
      post 'register', to: 'profile#register'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
