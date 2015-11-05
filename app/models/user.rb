class User < ActiveRecord::Base

  has_many :deals, dependent: :destroy
  
<<<<<<< HEAD
  validates         :name, :address, :password, :password_confirmation, presence: true
  # validate          :validate_address
=======
  validates         :name, :address, :phone_number, :hours, :password_confirmation, presence: true
  validates         :password, confirmation: true
  validate          :validate_address
>>>>>>> 95dbed5798bc54af5e000c2c92aa113a27a79b99
  validates         :email, email: true
  phony_normalize   :phone_number, default_country_code: 'US'
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  has_secure_password


  def validate_address
    if StreetAddress::US.parse(address).nil?
      errors.add(address, "Need a valid address")
    end
  end
  
end