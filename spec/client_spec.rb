require('spec_helper')

describe(Client) do

  describe('#c_name') do
    it("returns the name of a client") do
      bob = Client.new(c_name: "Bob", stylist_id: nil, id: nil)
      expect(bob.c_name()).to(eq("Bob"))
    end
  end

  describe("#id") do
    it("returns the id") do
      bob = Client.new(c_name: "Bob", stylist_id: nil, id: 1)
      expect(bob.id()).to(eq(1))
    end
  end
end
