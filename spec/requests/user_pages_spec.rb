require 'spec_helper'

describe "UserPages" do

  subject { page }

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

  end

end


