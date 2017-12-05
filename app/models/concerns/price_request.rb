class PriceRequest
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks

  attr_accessor :address, :avg_long_term_rental, :region
  validates_presence_of :address
  validates_presence_of :avg_long_term_rental

  def rent_diffrence
    avg_long_term_rental.to_f - airbnb_monthly_rent
  end

  def airbnb_monthly_rent
    return @airbnb_avg_rent if @airbnb_avg_rent
    @airbnb_avg_rent ||= 0.0
    airbnb = Location::Airbnb.new(location_attributes)
    result = airbnb.monthly_rentail_details
    airbnb_avg_rent = result[:data]['average_income']
    @airbnb_avg_rent = Float(airbnb_avg_rent.gsub!(/\D/, ''))
  end

  def location_attributes
    { address: address, region: region }
  end
end
