class Deal < ActiveRecord::Base

  FOOD_TYPES = [ 'American',
                 'Mexican',
                 'Italian',
                 'Asian',
                 'French', 
                 'Other',
                  ]

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
  validates :food_name, :address, :food_type, :start_time, :end_time, presence: true
  # geocoded_by      :address
  # after_validation :geocode

end
