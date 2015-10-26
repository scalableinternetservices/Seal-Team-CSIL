class Deal < ActiveRecord::Base

  belongs_to :user

  #Lat and Lng generated anyway if valid address
  validates :food_name, :address, :start_time, :end_time, presence: true
  #only validates accurate address format, not if its a non-real address
  validate         :validate_address
  validates        :deal_type, inclusion: [ 'Free', 'Buy one Get one Free', 'Buy one Get one Half Off' ]
  geocoded_by      :address
  after_validation :geocode

  def validate_address
    if StreetAddress::US.parse(address).nil?
      errors.add(address, "Need a valid address")
    end
  end

end
