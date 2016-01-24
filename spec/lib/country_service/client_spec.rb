require 'rails_helper'

describe CountryService::Client do

  subject { described_class.new }

  it 'should create savon client' do
    expect(Savon).to receive(:client).with(wsdl: CountryService::WDSL_SERVICE_URL)
    described_class.new
  end

  describe '#call' do
    specify 'client.call exception' do
      expect_any_instance_of(Savon::Client).to receive(:call)
        .with(:test, message: {}).and_raise(Savon::Error.new)
      expect(Rails).to receive_message_chain(:logger, :info).with("CountryService::Client#call")
      expect(subject).to receive(:parse_response).with('').and_return({})

      expect(subject.call(:test)).to eq({})
    end

    describe 'successful response' do
      let(:xml_response) do
        <<RESPONSE
        <NewDataSet>
          <Table>
            <Name>Ukraine</Name>
          </Table>
          <Table>
            <Name>USA</Name>
          </Table>
        </NewDataSet>
RESPONSE
      end

      it 'should return list' do
        expect_any_instance_of(Savon::Client).to receive(:call).with(:test, message: {})
          .and_return(double(body: { test_response: { test_result: xml_response } }))

        expect(subject.call(:test)).to eq [{ name: 'Ukraine' }, { name: 'USA' }]
      end

      it 'should return first' do
        expect_any_instance_of(Savon::Client).to receive(:call).with(:test, message: { 'CountryName' => 'Ukraine' })
          .and_return(double(body: { test_response: { test_result: xml_response } }))

        expect(subject.call(:test, 'CountryName' => 'Ukraine')).to eq({ name: 'Ukraine' })
      end
    end
  end
end
