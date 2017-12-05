# spec/services/location/airbnb_service_spec.rb
describe 'Airbnb' do
  AirbnbParams = { address: 'Indore', region: 'Indore' }.freeze

  it 'gets monthly rent form Airbnb' do
    VCR.use_cassette('airbnb_api') do
      airbnb = Location::Airbnb.new(AirbnbParams)
      response = airbnb.monthly_rentail_details
      expect(response[:data]['average_income']).to eq '₹39,508'
    end
  end

  it 'gets weekly rent form Airbnb' do
    VCR.use_cassette('airbnb_api') do
      airbnb = Location::Airbnb.new(AirbnbParams)
      response = airbnb.weekly_rentail_details
      expect(response[:data]['average_income']).to eq '₹9,219'
    end
  end

  it 'gets yearly rent form Airbnb' do
    VCR.use_cassette('airbnb_api') do
      airbnb = Location::Airbnb.new(AirbnbParams)
      response = airbnb.yearly_rentail_details
      expect(response[:data]['average_income']).to eq '₹4,87,428'
    end
  end
end
