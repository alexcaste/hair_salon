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

end
