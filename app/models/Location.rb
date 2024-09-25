class Location
  include ActiveModel::Validations
  attr_accessor :zip, :name, :lat, :lon, :country, :current_weather, :from_cache
  validates :zip, presence: true, format: { with: /\A\d{5}\z/ }

  def initialize(zip = nil)
    @zip = zip
  end
end
