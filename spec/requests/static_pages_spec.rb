require 'spec_helper'

describe "StaticPages" do

  describe "Home page" do
  	it "Should have the content Report app" do
  		visit '/static_pages/home'
  		page.should have_content('Report app')
  	end

    it "should have base title 'Reporting app'" do
      visit '/static_pages/home'
      page.should have_selector('title',text: "Reporting app")
    end

    it "should have page title 'Home'" do
      visit '/static_pages/home'
      page.should have_selector('title',text: "| Home")
    end
  end

  describe "Help page" do
  	it "should have the econtent Help" do
  		visit '/static_pages/help'
  		page.should have_content('Help')
  	end

    it "should have base title 'Reporting app'" do
      visit '/static_pages/help'
      page.should have_selector('title',text: "Reporting app")
    end

    it "should have title 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('title',text: "| Help")
    end
  end

  describe "About us" do
    it "should have the content about us" do
      visit '/static_pages/about'
      page.should have_content('About')
    end

    it "should have base title 'Reporting app'" do
      visit '/static_pages/about'
      page.should have_selector('title',text: "Reporting app")
    end

    it "should have title 'About us'" do
      visit '/static_pages/about'
      page.should have_selector('title',text: "| About us")
    end
  end
  
end
