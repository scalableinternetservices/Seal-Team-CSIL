class User < ActiveRecord::Base

  has_many :deals, dependent: :destroy

	has_secure_password
  
end
