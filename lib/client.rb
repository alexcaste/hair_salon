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
        c_name = client.fetch("t_name")
        id = client.fetch("id").to_i()
        stylist_id = client.fetch("stylist_id").to_i()
        clients.push(Client.new({c_name: c_name, stylist_id: stylist_id, id: id}))
      end
      clients
    end

end
