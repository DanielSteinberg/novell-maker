module UserForms
  class RegisterForm < JsonSchemaForm
    form :post, url.register_user_path
    prop :email, type: 'string', format: 'email', description: 'email'
    prop :password, type: 'string', format: 'password', description: 'password'
  end
end
