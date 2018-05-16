class UsersController < ApplicationController
  before_action :require_login, only: [:cabinet]
  before_action :redirect_to_cabinet, only: [
    :login_form, :login_user, :register_form, :register_user
  ], if: :logged_in?
  
  def login_form
    respond_to do |format|
      format.html { render 'login_form' }
    end
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
    respond_to do |format|
      format.html { render 'register_form' }
    end
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
    redirect_to login_form_path
  end
  
  def cabinet
    # use current_user
    respond_to do |format|
      format.html { render 'cabinet' }
    end
  end
  
  protected
  
  def user_params
    params.require(:user).permit(:email, :password)
  rescue ActionController::ParameterMissing
    nil
  end
  
  def redirect_to_cabinet
    redirect_to cabinet_user_path
  end
end
