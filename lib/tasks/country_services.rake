namespace :country_services do
  desc 'Load countries to database'
  task load_to_db: :environment do
    db_connection = ActiveRecord::Base.connection
    country_codes_exist = Country.pluck(:code)

    # Exclude the existing countries
    countries_for_save = CountryService.currencies.select do |country|
      country_codes_exist.exclude?(country[:country_code])
    end

    # Build SQL VALUES part
    sql_values = countries_for_save.map do |country|
      puts "Insert #{country[:name]}"

      "(\"#{[country[:name], country[:country_code], country[:currency], country[:currency_code]].join('", "')}\")"
    end.join(', ')

    if sql_values.present?
      db_connection.execute("INSERT INTO countries (name, code, currency_name, currency_code) VALUES #{sql_values}")
    end

    puts "Inserted #{sql_values.length} new countries."
  end
end
