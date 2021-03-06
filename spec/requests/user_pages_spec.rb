require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "index" do
    before do 
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user,name: "bob", email: "bob@gmail.com")
      FactoryGirl.create(:user, name: "ben", email: "ben@gmail.com")
      visit users_path
    end
    it { should have_selector('title', text: 'All user') }
    it { should have_selector('h1', text: 'All users') }

    it "should list each user" do
      User.all.each do |user|
        page.should have_selector('li', text: user.name )
      end
    end

    describe "delete links" do
      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end
        it { should have_link('delete',href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('delete') }.to change(User,:count).by(-1)
        end
        it { should_not have_link('delete',href: user_path(admin)) }
      end
    end
  end
  
  describe "edit" do
    let(:user){ FactoryGirl.create(:user) }
    before do 
      sign_in user
      visit edit_user_path(user) 
    end
    describe "Page" do
      it { should have_selector('h1', text: "Make changes to your Profile") }
      it { should have_selector('title', text: "Edit user") }
      it { should have_link('change', href: "http://gravatar.com/emails") }
    end
    describe "with invalid info" do
      before { click_button "Save changes" }
      it { should have_content('error') }
    end
    describe "with valid info" do
      let(:new_name) { "steve jobs" }
      let(:new_email) { "stevejobs@apple.com" }
      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirm password", with: user.password
        click_button "Save changes"
      end

      it { should have_selector('title',text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out',href: signout_path) }
      specify { user.reload.name.should == new_name }
      specify { user.reload.email.should == new_email }
    end
  end
  describe "signup page" do
  	before { visit signup_path }

  	it { should have_selector('h1', text: 'Sign up') }
  	it { should have_selector('title', text: full_title('Sign up')) }
  end

  describe "profile pages" do
  	let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:reports, user: user, content: "foo") }
    let!(:m2) { FactoryGirl.create(:reports, user: user, content: "bar") }
  	before { visit user_path(user) }

  	it { should have_selector('h1', text: user.name) }
  	it { should have_selector('title', text: user.name) }

    describe "Reports" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
    end
    
  end

  describe "signup" do
    before { visit signup_path }
    let(:submit) { "Create my account" }
    describe "with invalid info" do
      it "should not create user" do
        expect{ click_button submit }.not_to change(User,:count)
      end
    end

    describe "With valid info " do
      before do
        fill_in "Name", with: "Example user"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      it "should create a user" do
        expect { click_button submit }.to change(User,:count).by(1)
      end

      describe "after saving" do
        before { click_button submit }
        it { should have_link('Sign out') }
      end
    end
  end  
end
