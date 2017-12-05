class PriceRequest
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks

  attr_accessor :address, :avg_long_term_rental, :region
  validates_presence_of :address
  validates_numericality_of :avg_long_term_rental
  validate :airbnb_is_up

  def rent_diffrence
    avg_long_term_rental.to_f - airbnb_monthly_rent
  end

  def airbnb_monthly_rent
    airbnb_avg_rent = airbnb_response[:data]['average_income']
    airbnb_avg_rent.gsub!(/\D/, '')
    Float(airbnb_avg_rent)
  end

  private

  def airbnb_response
    return @airbnb_response if @airbnb_response
    airbnb = Location::Airbnb.new(location_attributes)
    @airbnb_response = airbnb.monthly_rentail_details
  end

  def airbnb_is_up
    return if errors.any? || airbnb_response[:success]
    errors.add(:base, 'Airbnb Service is Down please Try again later')
  end

  def location_attributes
    { address: address, region: region }
  end
end
