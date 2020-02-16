Rails.application.routes.draw do
  scope 'api' do
    resources :users

    post 'auth', to: 'auth#auth'
    get 'me', to: 'auth#me'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
