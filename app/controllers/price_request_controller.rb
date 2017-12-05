class PriceRequestController < ApplicationController
  def new
    @price_request = PriceRequest.new
  end

  def create
    @price_request = PriceRequest.new(price_request_params)
    if @price_request.valid? && @price_request.airbnb_monthly_rent
      render json: { average_airbnb_income: @price_request.airbnb_monthly_rent,
                     rent_diffrence: @price_request.rent_diffrence }.to_json, status: 200
    else
      render json: { error: @price_request.errors.messages }.to_json, status: :unprocessable_entity
   end
  end

  private

  def price_request_params
    params.require(:price_request).permit(:address, :region, :avg_long_term_rental)
  end
end
