# spec/features/auth_spec.rb

require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  before :each do
    visit "/users/new"
  end

  it "has a new user page" do
    expect(page).to have_content("Create User")
  end

  feature "signing up a user" do
    it "shows username on the homepage after signup" do
      fill_in "Username", with: "batman"
      fill_in "Password", with: "alfred"
      click_button "Create User"
      expect(page).to have_content("batman")
    end
  end
end

feature "logging in" do

  before :each do
    visit "/users/new"
    fill_in "Username", with: "batman"
    fill_in "Password", with: "alfred"
    save_and_open_page
    click_button "Create User"
    visit "session/new"
  end

  it "shows username on the homepage after login" do
    fill_in "Username", with: "batman"
    fill_in "Password", with: "alfred"

    click_button "Sign In"
    expect(page).to have_content("batman")
  end
end

feature "logging out" do

  before :each do
    visit "/users/new"
    fill_in "Username", with: "batman"
    fill_in "Password", with: "alfred"
    save_and_open_page
    click_button "Create User"
    visit "session/new"
  end

  it "begins with logged out state" do
    expect(page).to have_content("Sign In")
  end

  it "doesn't show username on the homepage after logout" do
    fill_in "Username", with: "batman"
    fill_in "Password", with: "alfred"

    click_button "Sign In"
    click_button "Sign Out"
    expect(page).to_not have_content("batman")
  end
end
