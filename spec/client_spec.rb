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

  describe("#stylist_id") do
    it("returns the stylist_id") do
      bob = Client.new(c_name: "Bob", stylist_id: 1, id: nil)
      expect(bob.stylist_id()).to(eq(1))
    end
  end

  describe(".all") do
    it("starts off with no trains") do
      expect(Client.all()).to(eq([]))
    end
  end

  describe(".find") do
    it("returns a client by its ID number") do
      bob = Client.new(c_name: "Bob", stylist_id: 1, id: nil)
      bob.save()
      dan = Client.new(c_name: "Dan", stylist_id: 1, id: nil)
      dan.save()
      expect(Client.find(bob.id())).to(eq(bob))
    end
  end
end
