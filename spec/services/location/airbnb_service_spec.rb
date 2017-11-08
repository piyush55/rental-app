# spec/services/location/airbnb_service_spec.rb
describe 'Airbnb' do
  AirbnbParams = { address: 'Indore', region: 'Indore' }.freeze

  it 'gets monthly rent form Airbnb' do
    VCR.use_cassette('airbnb_api') do
      airbnb = Location::Airbnb.new(AirbnbParams)
      response = airbnb.monthly_rentail_details
      expect(response[:data]['average_income']).to eq "₹37,611"
    end
  end

  it 'gets weekly rent form Airbnb' do
    VCR.use_cassette('airbnb_api') do
      airbnb = Location::Airbnb.new(AirbnbParams)
      response = airbnb.weekly_rentail_details
      expect(response[:data]['average_income']).to eq "₹8,776"
    end
  end

  it 'gets yearly rent form Airbnb' do
    VCR.use_cassette('airbnb_api') do
      airbnb = Location::Airbnb.new(AirbnbParams)
      response = airbnb.yearly_rentail_details
      expect(response[:data]['average_income']).to eq "₹4,89,730"
    end
  end
end