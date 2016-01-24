require 'rails_helper'

describe CountryService do
  specify '.countries' do
    expect(described_class).to receive_message_chain(:country_client, :call).with(:get_countries)

    described_class.countries
  end

  specify '.country_name_by_country_code' do
    expect(described_class).to receive_message_chain(:country_client, :call)
      .with(:get_country_by_country_code, 'CountryCode' => 'ua')

    described_class.country_name_by_country_code('ua')
  end

  specify '.country_code_by_country_name' do
    expect(described_class).to receive_message_chain(:country_client, :call)
      .with(:get_iso_country_code_by_county_name, 'CountryName' => 'Ukraine')

    described_class.country_code_by_country_name('Ukraine')
  end

  specify '.country_by_currency_code' do
    expect(described_class).to receive_message_chain(:country_client, :call)
      .with(:get_country_by_currency_code, 'CurrencyCode' => 'UAH')

    described_class.country_by_currency_code('UAH')
  end

  specify '.currencies' do
    expect(described_class).to receive_message_chain(:country_client, :call).with(:get_currencies)

    described_class.currencies
  end

  specify '.currency_by_country_name' do
    expect(described_class).to receive_message_chain(:country_client, :call)
      .with(:get_currency_by_country, 'CountryName' => 'Ukraine')

    described_class.currency_by_country_name('Ukraine')
  end

  specify '.currency_code_by_currency_name' do
    expect(described_class).to receive_message_chain(:country_client, :call)
      .with(:get_currency_code_by_currency_name, 'CurrencyName' => 'Hryvnia')

    described_class.currency_code_by_currency_name('Hryvnia')
  end

  specify '.gmt_offset_by_country_name' do
    expect(described_class).to receive_message_chain(:country_client, :call)
      .with(:get_gm_tby_country, 'CountryName' => 'Ukraine')

    described_class.gmt_offset_by_country_name('Ukraine')
  end

  specify '.dialing_code_by_country_name' do
    expect(described_class).to receive_message_chain(:country_client, :call)
      .with(:get_isd, 'CountryName' => 'Ukraine')

    described_class.dialing_code_by_country_name('Ukraine')
  end

  describe 'private methods' do
    describe '.country_client' do
      it 'should return client object' do
        expect(described_class.send(:country_client)).to be_a(CountryService::Client)
      end

      it 'should cache client object' do
        client = described_class.send(:country_client)
        expect(described_class.send(:country_client)).to eq(client)
      end
    end
  end
end
