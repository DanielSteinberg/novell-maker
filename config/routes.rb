Rails.application.routes.draw do
  root to: 'static_pages#index'
  
  def api_and_normal_routes
    resource :user, only: [], as: '' do
      collection do
        options = ->(key) do
          {action: key, as: key, format: :html}
        end
        
        get  'login',    options.call('login_form')
        post 'login',    options.call('login_user')
        get  'register', options.call('register_form')
        post 'register', options.call('register_user')
        post 'logout',   options.call('logout_user')
        
        get 'cabinet', as: 'cabinet_user'
      end
    end
  end
  
  api_and_normal_routes
  
  namespace :api do
    api_and_normal_routes
  end
end
