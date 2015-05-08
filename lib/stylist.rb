class Stylist

attr_reader(:s_name, :id)

  define_method(:initialize) do |attributes|
    @s_name = attributes.fetch(:s_name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_stylists = DB.exec("SELECT * FROM stylists;")
    stylists = []
    returned_stylists.each() do |stylist|
      s_name = stylist.fetch("s_name")
      id = stylist.fetch("id").to_i()
      stylists.push(Stylist.new({s_name: s_name, id: id}))
    end
    stylists
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stylists (s_name) VALUES ('#{@s_name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  define_singleton_method(:find) do |id|
    @id = id
    result = DB.exec("SELECT * FROM stylists WHERE id = #{@id};")
    @s_name = result.first().fetch("s_name")
    @id = result.first().fetch("id").to_i()
    Stylist.new({s_name: @s_name, id: @id})
  end

  define_method(:==) do |dup_styl|
     self.s_name().==(dup_styl.s_name()).&(self.id().==(dup_styl.id()))
  end

  define_method(:update) do |attributes|
    @s_name = attributes.fetch(:s_name, @s_name)
    @id = self.id()
    DB.exec("UPDATE stylists SET s_name ='#{@s_name}' WHERE id = #{@id};")
  end


  define_method(:delete) do
    DB.exec("DELETE FROM stylists WHERE id =#{self.id()};")
  end

  define_method(:all_clients) do
    returned_clients = []
    stylist_table = DB.exec("SELECT * FROM clients WHERE stylist_id = #{self.id()};")
    stylist_table.each() do |client|
      c_name = client.fetch("c_name")
      stylist_id = client.fetch("stylist_id").to_i()
      id = client.fetch("id").to_i()
      returned_clients.push(Client.new({c_name: c_name, stylist_id: stylist_id, id: id}))
    end
    returned_clients
  end

  define_method(:not_clients) do
    not_clients = []
    id = self.id()
    stylist = DB.exec("SELECT * FROM clients WHERE stylist_id != #{id};")
    stylist.each() do |client|
      c_name = client.fetch("c_name")
      stylist_id = client.fetch("stylist_id").to_i()
      id = client.fetch("id").to_i()
      not_clients.push(Client.new({c_name: c_name, stylist_id: stylist_id, id: id}))
    end
    not_clients
  end
end
