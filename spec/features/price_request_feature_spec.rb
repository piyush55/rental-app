describe 'Compare Rent with Airbnb', type: :feature do
  it 'should show error message when fields are blank' do
    visit '/'
    find('.btn-compare').click
    expect(page).to have_content("Address can't be blank")
    expect(page).to have_content('Monthly Average Rental is not a number')
  end

  it 'should show rent diffrence' do
    visit '/'
    VCR.turn_on!
    VCR.use_cassette('airbnb_api') do
      fill_in('geo_address', with: "indore\n")
      fill_in('price_request_avg_long_term_rental', with: '19000')
      fill_in('geo_address', with: "indore\n")
      find('.btn-compare').click
      expect(page).to have_content('Airbnb Rent: 39915')
      expect(page).to have_content('Rent Diffrence: -20915')
    end
  end
end
