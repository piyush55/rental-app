class LocationsController < ApplicationController
  def index
    @price_request = PriceRequest.new
  end

  def compare
    airbnb = Location::Airbnb.new(rental_params.merge(location_params))
    result = airbnb.monthly_rentail_details
    airbnb_avg_rent = result[:data]['average_income']
    airbnb_avg_rent.gsub!(/\D/, '')
    render json: { average_income: airbnb_avg_rent }.to_json, status: 200
  end


  private
  def location_params
    params.require(:location).permit(:address, :region)
  end

  def rental_params
    params.permit(:avg_long_term_rental)
  end
end
