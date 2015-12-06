class User < ActiveRecord::Base

  has_many :deals, dependent: :destroy
  
  validates         :name, :password, :password_confirmation, presence: true
  validates         :email, email: true
  validates         :phone_number, phony_plausible: true
  has_attached_file :avatar
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  has_secure_password
  
end
