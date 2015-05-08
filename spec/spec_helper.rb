require 'rspec'
require 'client'
require 'pg'
require 'stylist'

DB = PG.connect(dbname: 'hair_salon_test')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM clients *;")
    DB.exec("DELETE FROM stylists *;")
  end
end
