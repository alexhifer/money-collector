require 'savon'

module CountryService
  class Client
    def initialize(service_url = WDSL_SERVICE_URL)
      @client = Savon.client(wsdl: service_url)
    end

    def call(operation, parameters = {})
      response_xml = ''

      begin
        response = @client.call(operation, message: parameters)
      rescue Savon::Error => error
        Rails.logger.info "#{self.class}#call" do
          error.message
        end
      else
        response_xml = response_body_xml(operation, response)
      end

      response_data = parse_response(response_xml)
      parameters.present? ? response_data.first : response_data
    end

    private

    def parse_response(response_xml)
      xml = Nokogiri::XML(response_xml)

      xml.xpath('/NewDataSet/Table').map do |table|
        table.xpath('./*').each_with_object({}) do |node, res|
          res[node.name.underscore.to_sym] = node.text
        end
      end
    end

    def response_body_xml(operation, response)
      response_hash = response.body
      response_key = response_key(operation)
      response_result_key = response_result_key(operation)
      should_hash = { response_key => { response_result_key => '' } }

      should_hash.merge(response_hash)[response_key][response_result_key]
    end

    def response_key(operation)
      "#{operation}_response".to_sym
    end

    def response_result_key(operation)
      "#{operation}_result".to_sym
    end
  end
end
