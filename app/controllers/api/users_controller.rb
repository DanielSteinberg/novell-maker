module Api
  class UsersController < ApiApplicationController
    before_action :require_login, only: [:cabinet]
    before_action :redirect_to_cabinet, only: [
      :login_form, :login_user, :register_form, :register_user
    ], if: :logged_in?
    
    def login_form
      render json: UserForms::LoginForm.to_h
    end
    
    def login_user
      up = user_params
      if up && login(up[:email], up[:password])
        redirect_back_or_to cabinet_user_path
      else
        flash[:error] = I18n.t('user.login.failed')
        render action: 'login_form'
      end
    end
    
    def register_form
      render json: UserForms::RegisterForm.to_h
    end
    
    def register_user
      up = user_params
      @user = up && User.create(up)
      if @user && login(up[:email], up[:password])
        redirect_back_or_to cabinet_user_path
      else
        flash[:error] = I18n.t('user.register.failed')
        render action: 'register_form'
      end
    end
    
    def logout_user
      logout
      redirect_to api_login_form_path
    end
    
    def cabinet
    end
  
    protected
    
    def redirect_to_cabinet
      redirect_to api_cabinet_user_path
    end
  end
end
