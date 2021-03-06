Rails.application.routes.draw do
  scope 'api' do
    resources :users

    scope 'profile' do
      get '/', to: 'profile#me'
      put '/', to: 'profile#edit'
      post 'auth', to: 'profile#auth'
      post 'register', to: 'profile#register'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
