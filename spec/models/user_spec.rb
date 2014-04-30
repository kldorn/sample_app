require 'spec_helper'
 
describe User do
  #Listing 6.5.   
  #pending "add some examples to (or delete) #{__FILE__}"
  #    Testing for the :name and :email attributes. 
  
  #Listing 6.5.
  #before { @user = User.new(name: "Example User", email: "user@example.com") }
  #Listing 6.8. A failing test for validation of the name attribute.
  before do
    #@user = User.new(name: "Example User", email: "user@example.com")
    #Listing 6.24. Testing for the password and password_confirmation attributes. 
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end
 
  #Listing 6.5.  
  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
 
  #Listing 6.22. Ensuring that a User object has a password_digest column.
  it { should respond_to(:password_digest) }

  #Listing 6.8. A failing test for validation of the name attribute.
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  #Listing 8.15. A first test for the remember token. 
  # User ID is stored 
  it { should respond_to(:remember_token) }
  # Dependent on class class AddRememberTokenToUsers < ActiveRecord::Migration
  # Listing 8.16. A migration to add a remember_token to the users table. 

  #Listing 6.28. Tests for password length and the authenticate method. 
  it { should respond_to(:authenticate) }

  #Listing 9.38: Tests for an admin attribute.
  it { should respond_to(:admin) }
  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
      #The toggle! method flips the admin attribute from false to true.
    end
    it { should be_admin }
    #implies (via the RSpec boolean convention) 
    #that the user should have an admin? boolean method.
    #admin is a new attribute on user
  end

  #Listing 6.8. A failing test for validation of the name attribute. 
  it { should be_valid }

  #Listing 9.38: Tests for an admin attribute.
  it { should_not be_admin }

  #Listing 6.8. A failing test for validation of the name attribute. 
  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  #Listing 6.9. A test for presence of the email attribute. 
  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  #Listing 6.11. A test for name length validation. 
  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end


  #       Goes with code in /app/models/user.rb
  #Listing 6.13. Tests for email format validation. 
  describe "when email format is invalid" do
   it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com  foo@xxx..com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
     end
    end
  end

  #Listing 6.13. Tests for email format validation. 
  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  #Listing 6.30. A test for the email downcasing from Listing 6.20.
  # To test this, you must comment out a line in ~app/models/user.rb
  # before_save { self.email = email.downcase }
  # which converts the address to lower case before saving it
  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end

  #Listing 6.15. A test for the rejection of duplicate email addresses. 
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      #Listing 6.17. A test for the rejection of duplicate email addresses, insensitive to case. 
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  #Listing 6.8. A failing test for validation of the name attribute.
  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com",
                     password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  # The has_secure_password in app/models/user.rb 
  # must be commmented out for this to fail


#Listing 6.28. Tests for password length and the authenticate method.
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end

  # Listing 8.17. A test for a valid (nonblank) remember token. 
  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

end
