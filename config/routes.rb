Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :auth do
    post '/sign_up', to: 'signup#sign_up'
    post '/sign_in', to: 'signin#sign_in'
    post '/refresh_token', to: 'refresh#refresh_token'
  end
end
