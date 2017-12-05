class PriceRequest
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks

  attr_accessor :address, :avg_long_term_rental, :region
  validates_presence_of :address
  validates_presence_of :avg_long_term_rental
end
