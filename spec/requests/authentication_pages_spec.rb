require 'spec_helper'

#Listing 8.1. Tests for the new session action and view. 
describe "Authentication" do
  
  subject { page }
  
  describe "signin page" do
    before { visit signin_path }
    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end

  #Listing 8.5. The tests for signin failure. 
  describe "signin" do
    before { visit signin_path }
    describe "with invalid information" do
      before { click_button "Sign in" }
      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-error') }
      
      #Listing 8.11. Correct tests for signin failure. 
      describe "after visiting another page" do
      #check for flash message persistance on subsequent pages.
      #The flash should go away when you go to another page.
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
        #Re-render page with error message if signon is invalid
      end
    end
  end

  # Listing 8.6. Test for signin success. 
  describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end
      it { should have_title(user.name) }
      it { should have_link('Profile',     href: user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
      # Capybara’s have_link method. 
      # It takes as arguments the text of the link and an optional 
      # :href parameter, so that
      # it { should have_link('Profile', href: user_path(user)) }
      # ensures that the anchor tag a has the right href 
      # (URL) attribute—in this case, a link to the user’s profile page.

      # Listing 8.28. A test for signing out a user. 
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end

  end

end