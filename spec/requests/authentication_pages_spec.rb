require 'spec_helper'

# \spec\requests\authentication_pages_spec.rb

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

      # Listing 9.5: Adding a test for the “Settings” link.
      before { sign_in user }

      # Removed in Listing 9.5: Adding a test for the “Settings” link.
      # This was moved to spec/support/utilities.rb
      #before do
      #  fill_in "Email",    with: user.email.upcase
      #  fill_in "Password", with: user.password
      #  click_button "Sign in"
      #end

      it { should have_title(user.name) }

      #Listing 9.26: A test for the “Users” link URL.
      it { should have_link('Users',       href: users_path) }
      
      it { should have_link('Profile',     href: user_path(user)) }

      # Listing 9.5: Adding a test for the “Settings” link.
      it { should have_link('Settings',    href: edit_user_path(user)) }

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

  end # describe "with valid information" do

  #Listing 9.11: Testing that the edit and update actions are protected.
  #Non signed in users are redirected to sign-on page
  #Only user owning profile can update the profile
  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

       # Listing 9.16: A test for friendly forwarding.      
       describe "when attempting to visit a protected page" do
        before do
          # To test for such “friendly forwarding”, 
          # we first visit the user edit page, 
          # which redirects to the signin page. 
          visit edit_user_path(user)
          # We then enter valid signin information and 
          # click the “Sign in” button. 
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end
        #The resulting page, 
        # which by default is the user’s profile, 
        # should in this case be the “Edit user” page.         
        describe "after signing in" do
          it "should render the desired protected page" do
            expect(page).to have_title('Edit user')
          end
        end
      end

      describe "in the Users controller" do
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
        end

        describe "submitting to the update action" do
          # Direct HTTP request "patch" in place of visit
          before { patch user_path(user) }
          # Test for server response
          specify { expect(response).to redirect_to(signin_path) }
        end

        # Listing 9.20: Testing that the index action is protected.
        # Testing that the index action is protected by 
        # visiting the users_path (Table 7.8) 
        #and verifying that we are redirected to the signin page.
        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title('Sign in') }
        end

      end # describe "in the Users controller" do

    end # describe "for non-signed-in users" do

    # Listing 9.13: Testing that the edit and update actions require the right user.
    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user, no_capybara: true }

      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Edit user')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end # describe "as wrong user" do


    #Listing 9.45: A test for protecting the destroy action.
    # Check that only admins can delete users, but also that other users can’t.
    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }
      before { sign_in non_admin, no_capybara: true }
      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end


  end # describe "authorization" do


end # describe "Authentication" do