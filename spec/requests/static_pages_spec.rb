require 'spec_helper'

#  describe "GET /static_pages" do
#    it "works! (now write some real specs)" do
#      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#      get static_pages_index_path
#      response.status.should be(200)
#    end
#  end
#end

describe "Static pages" do

  #Added from Listing 3.31
  let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  describe "Home page" do

    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end

    #Added from Rails tutorial Listing 3.19
    it "should have the title 'Home'" do
      visit '/static_pages/home'
      #expect(page).to have_title("Ruby on Rails Tutorial Sample App | Home")
      expect(page).to have_title("#{base_title} | Home")
    end

  end

describe "Help page" do

    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end

    #Added from Rails tutorial Listing 3.19
    it "should have the title 'Help'" do
      visit '/static_pages/help'
      #expect(page).to have_title("Ruby on Rails Tutorial Sample App | Help")
      expect(page).to have_title("#{base_title} | Help")
    end

  end

  describe "About page" do

    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_content('About Us')
    end

    #Added from Rails tutorial Listing 3.19
    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      #expect(page).to have_title("Ruby on Rails Tutorial Sample App | About Us")
      expect(page).to have_title("#{base_title} | About Us")
    end
    
   end

    #Added from Chap 3 exercizes
    describe "Contact page" do

    it "should have the content 'Contact'" do
      visit '/static_pages/contact'
      expect(page).to have_content('Contact')
    end

    #Added from Rails tutorial Listing 3.19
    it "should have the title 'Contact'" do
      visit '/static_pages/contact'
      #expect(page).to have_title("Ruby on Rails Tutorial Sample App | Contact")
      expect(page).to have_title("#{base_title} | Contact")
    end

  end

end

