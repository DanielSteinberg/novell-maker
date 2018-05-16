module UserForms
  class LoginForm < JsonSchemaForm
    form :post, url.login_user_path
    prop :email, type: 'string', format: 'email', description: 'email'
    prop :password, type: 'string', format: 'password', description: 'password'
  end
end
