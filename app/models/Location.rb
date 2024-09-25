class Location
  include ActiveModel::Validations
  attr_accessor :name, :lat, :lon, :country, :current_weather, :from_cache
  attr_reader :zip
  validates :zip, presence: true, format: { with: /\A\d{5}\z/ }

  def initialize(zip = nil)
    self.zip = zip
  end

  def zip=(value)
    @zip = value.to_s[0, 5]
  end
end
