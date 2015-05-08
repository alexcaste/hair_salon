class Client

attr_reader(:c_name, :stylist_id, :id)

    define_method(:initialize) do |attributes|
      @c_name = attributes.fetch(:c_name)
      @stylist_id = attributes.fetch(:stylist_id)
      @id = attributes.fetch(:id)
    end


end
