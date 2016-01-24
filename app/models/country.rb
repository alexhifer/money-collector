class Country < ActiveRecord::Base
  def self.currencies
    select('currency_name, currency_code')
      .where("currency_name != ''")
  end
end
