# money-collector

## How to play:
1. git clone https://github.com/alexhifer/money-collector.git
2. Execute in console "bundle install"
3. Configure file config/database.yml (MySQL database)
4. Execute in console "rake db:create && rake db:migrate && rake country_services:load_to_db"
5. Start server. Execute in console "rails s"