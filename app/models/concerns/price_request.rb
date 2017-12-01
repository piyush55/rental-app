class PriceRequest
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks

  attr_accessor :address, :avg_long_term_rental
end
