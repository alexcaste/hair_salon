require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exception, false)
require 'pry'

describe('the all stylists path', {:type => :feature}) do
  it("displays a list of stylists") do
    stylist = Stylist.new(s_name: "Zoolander", id: nil)
    stylist.save()
    visit('/')
    expect(page).to have_content(stylist.s_name())
  end
end

describe('the all clients path', {:type => :feature}) do
  it("displays a list of clients") do
    client = Client.new({c_name: "Dan", stylist_id: 1, id: nil})
    client.save()
    visit('/')
    expect(page).to have_content(client.c_name())
  end
end

describe('the save a stylists path', {:type => :feature}) do
  it("saves a stylist") do
    visit('/')
    fill_in('s_name', :with => "Zoolander")
    click_button('Add')
    expect(page).to have_content("Zoolander")
  end
end

describe('the delete a stylist path', {:type => :feature})do
  it("allows user to delete a stylist")do
  stylist = Stylist.new(s_name: "Zoolander", id: nil)
  stylist.save()
  visit('/')
  click_button('Delete')
  expect(page).to have_content('There are no stylists')
  end
end

describe('the view single stylist path', {:type => :feature})do
  it("displays the page for a single stylist")do
  stylist = Stylist.new(s_name: "Zoolander", id: nil)
  stylist.save()
  visit('/')
  click_link('Zoolander')
  expect(page).to have_content('Zoolander')
  end
end
