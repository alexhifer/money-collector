module CountryService
  WDSL_SERVICE_URL = 'http://www.webservicex.net/country.asmx?WSDL'.freeze

  class << self
    # Get all countries
    def countries
      country_client.call(:get_countries)
    end

    # Get country name by country code
    def country_name_by_country_code(country_code)
      country_client.call(:get_country_by_country_code, 'CountryCode' => country_code)
    end

    # Get country code by country name
    def country_code_by_country_name(country_name)
      country_client.call(:get_iso_country_code_by_county_name, 'CountryName' => country_name)
    end

    # Get country by currency code
    def country_by_currency_code(currency_code)
      country_client.call(:get_country_by_currency_code, 'CurrencyCode' => currency_code)
    end

    # Get all currency, currency code for all countries
    def currencies
      country_client.call(:get_currencies)
    end

    # Get currency by country name
    def currency_by_country_name(country_name)
      country_client.call(:get_currency_by_country, 'CountryName' => country_name)
    end

    # Get currency code by currency name
    def currency_code_by_currency_name(currency_name)
      country_client.call(:get_currency_code_by_currency_name, 'CurrencyName' => currency_name)
    end

    # Get greenwich mean time(GMT) by country name
    def gmt_offset_by_country_name(country_name)
      country_client.call(:get_gm_tby_country, 'CountryName' => country_name)
    end

    # Get International Dialing Code by country name
    def dialing_code_by_country_name(country_name)
      country_client.call(:get_isd, 'CountryName' => country_name)
    end

    private

    def country_client
      @country_client ||= CountryService::Client.new
    end
  end
end
