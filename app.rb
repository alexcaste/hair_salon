require 'sinatra'
require 'sinatra/reloader'
also_reload('lib/**/*.rb')
require('./lib/client')
require('./lib/stylist')
require('pg')

DB = PG.connect({:dbname => "hair_salon"})

get('/') do
  @clients = Client.all()
  @stylists = Stylist.all()
  erb(:index)
end

post('/stylists') do
  s_name = params.fetch("s_name")
  stylist = Stylist.new({s_name: s_name, id: nil}).save()
  @stylists = Stylist.all()
  @clients = Client.all()
  erb(:index)
end

delete('/stylists/:id') do
  @stylist = Stylist.find(params.fetch("id").to_i)
  @stylist.delete()
  @stylists = Stylist.all()
  @clients = Client.all()
  erb(:index)
end

get('/stylists/:id') do
  @stylist = Stylist.find(params.fetch("id").to_i())
  @clients = Client.all()
  erb(:stylists)
end
