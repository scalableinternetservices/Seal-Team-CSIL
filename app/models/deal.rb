class Deal < ActiveRecord::Base

  belongs_to :user

  #Lat and Lng generated anyway if valid address
  validates :food_name, :address, :start_time, :end_time, presence: true
  #only validates accurate address format, not if its a non-real address
  # validate         :validate_street_address
  validates        :deal_type, inclusion: [ 'Free', 'Buy one Get one Free', 'Buy one Get one Half Off' ]
  geocoded_by      :address
  after_validation :geocode

<<<<<<< HEAD
  # def validate_address
  #   if StreetAddress::US.parse(address).nil?
  #     errors.add(address, "Need a valid address")
  #   end
  # end
=======
  def validate_address
    if StreetAddress::US.parse(address).nil?
      errors.add(address, "Need a valid address")
    end
  end
>>>>>>> 95dbed5798bc54af5e000c2c92aa113a27a79b99

end
