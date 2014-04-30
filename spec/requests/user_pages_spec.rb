require 'spec_helper'

describe "UserPages" do

  subject { page }

  #Listing 9.22: Tests for the user index page.
  #Ensure that the index page has the right title/content 
  #and lists all of the site’s users. 
  #The method is to make three factory users 
  #(signing in as the first one) and then 
  #verify that the index page has a list element (li) tag 
  #for the name of each one. 
  #Note that we’ve taken care to give the users 
  #different names so that each element in the list 
  #of users has a unique entry, as shown in Listing 9.22.
  describe "index" do

    #Listing 9.32: Tests for pagination.
    let(:user) { FactoryGirl.create(:user) }

    #Listing 9.32: Tests for pagination.
    #before do
      #sign_in FactoryGirl.create(:user)
      #FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
      #FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
      #visit users_path
    #end
 
    # "before(:each) do removed again in" Listing 9.42: Tests for delete links.
    #before(:each) do
    #  sign_in user
    #  visit users_path
    #end
    before do
      sign_in user
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    #Listing 9.32: Tests for pagination.
    #it "should list each user" do
    #  User.all.each do |user|
    #    expect(page).to have_selector('li', text: user.name)
    #  end
    #end
    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      # Create sample users ONCE before test.
      after(:all)  { User.delete_all }
      # delete after test
      it { should have_selector('div.pagination') }
      it "should list each user" do
        # Note the replacement of the User.all array from Listing 9.22 
        # with User.paginate(page: 1)
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

    #Listing 9.42: Tests for delete links.
    describe "delete links" do
      it { should_not have_link('delete') }
      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end
        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect do
            click_link('delete', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end #  describe "delete links" do

    
  end # describe "index" do

  #Listing 7.6. A recap of the initial User pages spec. 
  # Gives Show action in app/controllers/users_controller.rb 
  # from Listing 7.5 something to find.
  # Tests HTML in app/views/users/show.html.erb
  describe "profile page" do
    # Replace with code to make a user variable
    # Listing 7.9. A test for the user show page. 
    # Creates a test user using FactoryGirl syntax
    # in the /spec/support/factories.rb file
    let(:user) { FactoryGirl.create(:user) }

    before { visit user_path(user) }
    # Uses user_path named route to generate path for given user.
    # user_path is provided by REST resource (table 7.1).
    # Then tests that page content and title have the user's name.    
    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "signup page" do
    before { visit signup_path }
    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  #Listing 7.16. Good basic tests for signing up users. 
  # Tests  app/views/users/new.html.erb 
  describe "signup" do

    before { visit signup_path }

    #Define symbol/variable for the button "submit" being tested
    # "Create my account is the text the user sees on the button"
    let(:submit) { "Create my account" }

    #Failing test for clicking button without an entry
    #Same as:
    #    initial = User.count
    #    click_button "Create my account"
    #    final = User.count
    #    expect(initial).to eq final
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      # Listing 7.31. Suggested error messages tests.
      describe "after submission" do
        before { click_button submit }
        it { should have_title('Sign up') }
        it { should have_content('error') }
      end
    end

    #Valid test when data entered
    #Same as:
    #    visit signup_path
    #    fill_in "Name",         with: "Example User"
    #    fill_in "Email",        with: "user@example.com"
    #    fill_in "Password",     with: "foobar"
    #    fill_in "Confirmation", with: "foobar"
    #    expect do
    #       click_button "Create my account"
    #    end.to change(User, :count).by(1)
    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      # Listing 7.32. Tests for the post-save behavior in the create action. 
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }
        
        #Listing 8.26. Testing that newly signed-up users are also signed in.
        it { should have_link('Sign out') }

        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end

  end  #describe "signup"

# Listing 9.1: Tests for the user edit page.
describe "edit" do
    let(:user) { FactoryGirl.create(:user) }

    #Listing 9.9: Tests for the user update action.
    #before { visit edit_user_path(user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      # Listing 9.9: Tests for the user update action.
      #before { click_button "Save changes" }
      #it { should have_content('error') }
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end

end # describe "UserPages" do


