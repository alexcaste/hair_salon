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
      c_name = stylist.fetch("c_name")
      id = stylist.fetch("id").to_i()
      stylists.push(Stylist.new({s_name: s_name, id: id}))
    end
    stylists
  end
end
