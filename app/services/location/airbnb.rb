module Location
  class Airbnb < Base
    URL = 'https://www.airbnb.com/wmpw_data.json'

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
      response = open(url_with_query_params(options), 'User-Agent' => 'Mozilla').read
      parsed_result = JSON.parse(response)
      return {
        success: true,
        data: parsed_result['data']
      }
    rescue Exception => e
      Rails.logger.log("======Error while fetch details from Airbnb======")
      Rails.logger.log(e.messsage)
      return {
        success: false,
        messsage: e.messsage,
        data: {}
      }
    end

    def url_with_query_params(options)
      options[:address] = @address
      options[:region] = @region
      "#{URL}?#{query_params(options)}"
    end

    def query_params(options)
      URI.encode(options.map{|k,v| "#{k}=#{v}" }.join("&"))
    end
  end
end
