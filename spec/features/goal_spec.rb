# spec/features/auth_spec.rb

require 'spec_helper'
require 'rails_helper'

feature "create goal on page" do

  before :each do
    visit "/users/new"
    fill_in "Username", with: "batman"
    fill_in "Password", with: "alfred"
    click_button "Create User"
  end

  it "shows a link for creating new goals" do
    expect(page).to have_link("Create New Goal")
  end

  feature "create new goal" do

    before :each do
      visit "/goals/new"
    end

    it "asks for private or public" do
      expect(page).to have_content("Private")
    end

    it "asks users for body" do
      expect(page).to have_content("Body")
    end

    it "returns user to homepage after goal creation" do
      fill_in "Body", with: "test goal"
      check('Private')
      click_button('Submit Goal')
      expect(page).to have_content("Home Page")
    end

  end
end

feature "edit goal on page" do

  before :each do
    visit "/users/new"
    fill_in "Username", with: "batman"
    fill_in "Password", with: "alfred"
    click_button "Create User"
    click_link "Create New Goal"
    fill_in "Body", with: "test goal"
    click_button('Submit Goal')
  end

  it "shows a link for editing goals" do
    expect(page).to have_link("Edit Goal")
  end

  feature "edit goal" do

    before :each do
      click_link 'Edit Goal'
    end

    it "asks for private or public" do
      expect(page).to have_content("Private")
    end

    it "asks users for body" do
      expect(page).to have_content("Body")
    end

    it "returns user to homepage after goal update" do
      fill_in "Body", with: "test goal"
      check('Private')
      click_button('Update Goal')
      expect(page).to have_content("Home Page")
    end

    it "actually updates the goal" do
      fill_in "Body", with: "updated goal"
      check('Private')
      click_button('Update Goal')
      expect(page).to have_content("updated goal")
    end

  end
end


feature "deletes goal on page" do
  #
  before :each do
    visit "/users/new"
    fill_in "Username", with: "batman"
    fill_in "Password", with: "alfred"
    click_button "Create User"
    click_link "Create New Goal"
    fill_in "Body", with: "test goal"
    click_button('Submit Goal')
  end

  it "shows a button for deletion on edit page" do
    expect(page).to have_button("Delete Goal")
  end

  it "redirects to homepage after deletion" do
    click_button("Delete Goal")
    expect(page).to have_content("Home Page")
  end

  it "actually destroys goal" do
    click_button("Delete Goal")
    expect(page).to_not have_content("test goal")
  end
  #
  # feature "delete goal" do
  #
  #   before :each do
  #     visit "/goal/1/edit"
  #   end
  #
  #   it "asks for private or public" do
  #     expect(page).to have_content("Private")
  #   end
  #
  #   it "asks users for body" do
  #     expect(page).to have_content("Body")
  #   end
  #
  #   it "returns user to homepage after goal update" do
  #     fill_in "Body", with: "test goal"
  #     check('Private')
  #     click_button('Update Goal')
  #     expect(page).to have_content("Home Page")
  #   end
  #
  #   it "actually updates the goal" do
  #     fill_in "Body", with: "updated goal"
  #     check('Private')
  #     click_button('Update Goal')
  #     expect(page).to have_content("updated goal")
  #   end
  #
  # end
end
