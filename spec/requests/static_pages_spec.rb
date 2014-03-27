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

  describe "Home page" do

    #5.3.4 Pretty RSpec
    #Replace redundant “visit root_path” with “before { visit root_path }”
    before { visit root_path }

    it { should have_content('Sample App') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_content('Help') }
    #it { should have_title(full_title('Help')) }
    it { should have_title("#{base_title} | Help") }
   
    #it "should have the title 'Help'" do     
    #  expect(page).to have_title("#{base_title} | Help")
    #end
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('About') }
    it { should have_title(full_title('About Us')) }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_content('Contact') }
    it { should have_title(full_title('Contact')) }
  end
end
