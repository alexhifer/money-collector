class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :code, limit: 2
      t.string :currency_name, limit: 30
      t.string :currency_code, limit: 3
    end
  end
end
