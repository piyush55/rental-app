module Location
  class Airbnb < Base
    base_uri 'https://www.airbnb.com'
    def initialize(options = {})
      super(options)
    end

    def monthly_rentail_details
      options = default_options.merge(duration: '1_month')
      fetch_details(options)
    end

    def weekly_rentail_details
      options = default_options.merge(duration: '1_week')
      fetch_details(options)
    end

    def yearly_rentail_details
      options = default_options.merge(duration: '1_year')
      fetch_details(options)
    end

    private

    def fetch_details(options)
      response = self.class.get('/wmpw_data.json', query: options, headers: headers)
      raise StandardError, response.response unless response.code == 200 || response.code == 201
      parsed_result = JSON.parse(response.body)
      return {
        success: true,
        data: parsed_result['data']
      }
    rescue Exception => e
      Rails.logger.info('======Error while fetch details from Airbnb======')
      Rails.logger.info(e.message)
      return {
        success: false,
        messsage: e.message,
        data: {}
      }
    end

    def headers
      { 'User-Agent' => 'Mozilla' }
    end
  end
end
