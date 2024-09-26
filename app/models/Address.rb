class Address
  include ActiveModel::Model
  attr_reader :zip
  validates :zip, presence: true, format: { with: /\A\d{5}\z/ }

  def zip=(value)
    @zip = value.to_s[0, 5]
  end
end
