class Client

attr_reader(:c_name, :stylist_id, :id)

  define_method(:initialize) do |attributes|
    @c_name = attributes.fetch(:c_name)
    @stylist_id = attributes.fetch(:stylist_id)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_clients = DB.exec("SELECT * FROM clients;")
    clients = []
    returned_clients.each() do |client|
      c_name = client.fetch("c_name")
      id = client.fetch("id").to_i()
      stylist_id = client.fetch("stylist_id").to_i()
      clients.push(Client.new({c_name: c_name, stylist_id: stylist_id, id: id}))
    end
    clients
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO clients (c_name, stylist_id) VALUES ('#{@c_name}', #{@stylist_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  define_singleton_method(:find) do |id|
    @id = id
    result = DB.exec("SELECT * FROM clients WHERE id = #{@id};")
    @c_name = result.first().fetch("c_name")
    @stylist_id = result.first().fetch("stylist_id").to_i()
    Client.new({c_name: @c_name, stylist_id: @stylist_id, id: @id})
  end

  define_method(:==) do |dup_client|
     self.c_name().==(dup_client.c_name()).&(self.stylist_id().==(dup_client.stylist_id())).&(self.id().==(dup_client.id()))
  end

  define_method(:update) do |attributes|
    @c_name = attributes.fetch(:c_name, @c_name)
    @stylist_id = attributes.fetch(:stylist_id, @stylist_id).to_i()
    @id = self.id()
    DB.exec("UPDATE clients SET c_name ='#{@c_name}', stylist_id = #{@stylist_id} WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM clients WHERE id =#{self.id()};")
  end

  define_method(:c_stylist) do
    stylist = Stylist.find(@stylist_id)
    stylist.s_name()
  end

end
