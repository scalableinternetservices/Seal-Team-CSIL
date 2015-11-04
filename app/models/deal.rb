class Deal < ActiveRecord::Base

  DEAL_TYPES = [ 'Free',
                 'Buy One Get One Free',
                 'Buy One Get One Half Off',
                 'Flash Deal' ]

  FOOD_TYPES = [ 'American',
                 'Mexican',
                 'Italian',
                 'Asian',
                 'French' ]

  DISTANCES = [ '1',
                '5',
                '10',
                '15',
                '20',
                '25',
                '30',
                '50',
                '100']

  belongs_to :user

  #Lat and Lng generated anyway if valid address
  validates :food_name, :address, :start_time, :end_time, presence: true
  #only validates accurate address format, not if its a non-real address
  validate         :validate_address
  geocoded_by      :address
  after_validation :geocode

  def validate_address
    if StreetAddress::US.parse(address).nil?
      errors.add(address, "Need a valid email address")
    end
  end

end
