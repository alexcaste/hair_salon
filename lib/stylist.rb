class Stylist

attr_reader(:s_name, :id)

  define_method(:initialize) do |attributes|
    @s_name = attributes.fetch(:s_name)
    @id = attributes.fetch(:id)
  end
end
