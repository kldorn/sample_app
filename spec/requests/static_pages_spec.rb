require 'spec_helper'

describe "Static pages" do

  #5.3.4 Pretty RSpec
  #Replace redundant expect(page). Do blocks with subject function ”
  subject { page }

  #Added from Listing 3.31 - Let function to define a variable
  let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  # Listing 5.29. A file for RSpec utilities with a full_title function. 
  # Creates user defined full_title(page_title) function in folder: 
  # spec/support/utilities.rb 
  # full_title(page_title) function can be used in place of 
  # let(:base_title) { "Ruby on Rails Tutorial Sample App" } variable definition

  # Listing 5.39. Using an RSpec shared example to eliminate test duplication. 
  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end

  # Listing 5.39. - eliminate test duplication. 
  describe "Home page" do
    before { visit root_path }
    let(:heading)    { 'Sample App' }
    let(:page_title) { '' }
    it_should_behave_like "all static pages"
    it { should_not have_title('| Home') }
  end

  #describe "Home page" do
    #5.3.4 Pretty RSpec
    #Replace redundant “visit root_path” with “before { visit root_path }”
  #  before { visit root_path }
  #  it { should have_content('Sample App') }
  #  it { should have_title(full_title('')) }
  #  it { should_not have_title('| Home') }
  #end

  # Listing 5.39. - eliminate test duplication.
  describe "Help page" do
    before { visit help_path }
    let(:heading)    { 'Help' }
    let(:page_title) { 'Help' }
    it_should_behave_like "all static pages"
  end

   #5.3.4 Pretty RSpec
  #describe "Help page" do
  #  before { visit help_path }
  #  it { should have_content('Help') }
  #  #it { should have_title(full_title('Help')) }
  #  it { should have_title("#{base_title} | Help") }   
  #  #it "should have the title 'Help'" do     
  #  #  expect(page).to have_title("#{base_title} | Help")
  #  #end
  #end

  # Listing 5.39. - eliminate test duplication.
  describe "About page" do
    before { visit about_path }
    let(:heading)    { 'About' }
    let(:page_title) { 'About Us' }   
  end

  #5.3.4 Pretty RSpec
  #describe "About page" do
  #  before { visit about_path }
  #  it { should have_content('About') }
  #  it { should have_title(full_title('About Us')) }
  #end

  # Listing 5.39. - eliminate test duplication.
  describe "Contact page" do
    before { visit contact_path }    
    #it { should have_selector('h1', text: 'Contact') }
    #it { should have_title(full_title('Contact')) }
    let(:heading)    { 'Contact' }
    let(:page_title) { 'Contact' }   
  end

  #5.3.4 Pretty RSpec
  #describe "Contact page" do
  #  before { visit contact_path }
  #  #it { should have_content('Contact') }
  #  #Listing 5.38. A more specific test for the Contact page. 
  #  #app/views/static_pages/contact.html.erb 
  #  #Use Capybara's have_selector method to test
  #  #the presense of specific HTML tags <h1>Contact</h1>.
  #  it { should have_selector('h1', text: 'Contact') }
  #  it { should have_title(full_title('Contact')) }
  #end

end
