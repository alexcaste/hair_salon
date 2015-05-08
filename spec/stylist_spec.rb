require('spec_helper')

describe(Stylist) do

  describe('#s_name') do
    it("returns the name of a stylist") do
      stylist = Stylist.new(s_name: "Zoolander", id: nil)
      expect(stylist.s_name()).to(eq("Zoolander"))
    end
  end

  describe("#id") do
    it("returns the id") do
      stylist = Stylist.new(s_name: "Zoolander", id: 1)
      expect(stylist.id()).to(eq(1))
    end
  end

  describe(".all") do
    it("starts off with no stylists") do
      expect(Stylist.all()).to(eq([]))
    end
  end
end
