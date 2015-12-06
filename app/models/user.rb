class User < ActiveRecord::Base

  has_many :deals, dependent: :destroy
  
  validates         :name, :password, :password_confirmation, presence: true
  # validate          :validate_address
  validates         :email, email: true
  validates         :phone_number, phony_plausible: true
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  has_secure_password
  
  def validate_address
    if StreetAddress::US.parse(address).nil?
      errors.add(address, "Need a valid address")
    end
  end
  
end
