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

post('/clients') do
  c_name = params.fetch("c_name")
  client = Client.new({c_name: c_name, stylist_id: 0, id: nil})
  client.save()
  @stylists = Stylist.all()
  @clients = Client.all()
  erb(:index)
end

delete('/clients/:id') do
  @client = Client.find(params.fetch("id").to_i)
  @client.delete()
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

get('/stylist/:id') do
  @stylist = Stylist.find(params.fetch("id").to_i())
  @clients = Client.all()
  erb(:stylist)
end

post('/stylist/:id/new_client') do
  @stylist = Stylist.find(params.fetch("id").to_i())
  stylist_id = @stylist.id()
  c_name = params.fetch("c_name")
  new_client = Client.new({c_name: c_name, stylist_id: stylist_id, id: nil})
  new_client.save()
  @clients = Client.all()
  erb(:stylist)
end

delete('/client/:id') do
  @client = Client.find(params.fetch("id").to_i)
  @client.delete()
  @stylist = Stylist.find(@client.stylist_id().to_i())
  @clients = Client.all()
  erb(:stylist)
end

patch('/stylist/:id') do
  stylist_id = params.fetch("stylist_id").to_i()
  @train = Train.find(stylist_id)
  city_id = params.fetch("id").to_i()
  @stylist = City.find(city_id)
  time = params.fetch("time").to_i()
  @train.update({city_ids: [city_id]})
  @train.add_time({time: time, city_id: city_id})
  @trains = Train.all()
  erb(:stylist)
end
