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
  @not_clients = @stylist.not_clients
  erb(:index)
end

get('/stylist/:id') do
  @stylist = Stylist.find(params.fetch("id").to_i())
  @clients = Client.all()
  @not_clients = @stylist.not_clients
  erb(:stylist)
end

post('/stylist/:id/new_client') do
  @stylist = Stylist.find(params.fetch("id").to_i())
  stylist_id = @stylist.id()
  c_name = params.fetch("c_name")
  new_client = Client.new({c_name: c_name, stylist_id: stylist_id, id: nil})
  new_client.save()
  @clients = Client.all()
  @not_clients = @stylist.not_clients
  erb(:stylist)
end

delete('/client/:id') do
  @client = Client.find(params.fetch("id").to_i)
  @client.delete()
  @stylist = Stylist.find(@client.stylist_id().to_i())
  @clients = Client.all()
  @not_clients = @stylist.not_clients
  erb(:stylist)
end

patch('/stylist_edit/:id') do
  s_name = params.fetch("s_name")
  id = params.fetch("stylist_id").to_i()
  stylist = Stylist.find(id.to_i())
  stylist.update({s_name: s_name, id: id})
  @clients = Client.all()
  @stylist = Stylist.find(id.to_i())
  @not_clients = @stylist.not_clients
  erb(:stylist)
end

post('/stylist/:id/add_client') do
  client_id = params.fetch("client_id").to_i()
  client = Client.find(client_id)
  c_name = client.c_name()
  stylist_id = params.fetch("id").to_i()
  client.update({:stylist_id => stylist_id})
  @stylist = Stylist.find(stylist_id)
  erb(:stylist)
end

patch('/edit_client') do
  c_name = params.fetch("c_name")
  client_id = params.fetch("client_id").to_i()
  client = Client.find(client_id.to_i())
  client.update({c_name: c_name, id: client_id})
  @clients = Client.all()
  @stylists = Stylist.all()
  erb(:index)
end
