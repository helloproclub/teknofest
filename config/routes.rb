Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope '/candidate' do
    get '/', to: redirect('/candidate/dashboard')

    get '/dashboard', to: 'candidates#index',
      as: 'candidate_dashboard'

    get '/register', to: 'candidates#new',
      as: 'candidate_register_get'
    post '/register', to: 'candidates#create',
      as: 'candidate_register_post'

    get '/login', to: 'candidates#login',
      as: 'candidate_login_get'
    post '/login', to: 'candidates#login_validation',
      as: 'candidate_login_post'

    get '/logout', to: 'candidates#logout',
      as: 'candidate_logout'
  end

  # TODO: Implement mentor dashboard
  scope '/mentor' do
    get '/dashboard', to: 'mentors#index',
      as: 'mentor_dashboard'
  end
end
