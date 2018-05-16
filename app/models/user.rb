class User < ApplicationRecord
  authenticates_with_sorcery!
  include EmailValidatable
  
  validates :email, email: true
  validates :password, length: {minimum: 4, message: I18n.t('user.password.length', min: 4)}, on: :create
end
