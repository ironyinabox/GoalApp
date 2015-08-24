# spec/features/auth_spec.rb

require 'spec_helper'
require 'rails_helper'


feature "create goal on page" do

  before :each do
    create_user('batman', 'alfred')
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

feature "goal access" do
  before :each do
    create_user('batman', 'alfred')
    create_goal('test goal')
  end

  feature "goal editing" do
    it "allows only owners to edit a goal" do
      click_button('Sign Out')
      create_user('jason', 'asdfasdf')
      visit "/goals/#{Goal.first.id}/edit"
      expect(page).to have_content("Home Page")
    end
  end

  feature "goal index" do
    it "shows all public goals" do
      visit "/goals"
      expect(page).to have_content("test goal")
    end

    it "does not show private goals" do
      create_goal('private goal', true)
      visit "/goals"
      expect(page).to_not have_content("private goal")
    end

    it "displays username next to goal" do
      visit "/goals"
      expect(page).to have_content("batman")
    end
  end

end


feature "edit goal on page" do

  before :each do
    create_user('batman', 'alfred')
    create_goal('test goal')
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

    it "redirects to home page when user tries to edit others' goals" do
      # visit goals/2/edit
    end

  end
end

feature "deletes goal on page" do
  #
  before :each do
    create_user('batman', 'alfred')
    create_goal('test goal')
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
end

feature "goal completion" do
  before :each do
    create_user('batman', 'alfred')
    create_goal('test goal')
  end

  it "starts out as incomplete" do
    expect(page).to have_content "Incomplete"
  end

  it "can be completed" do
    click_button "Toggle completion"
    expect(page).to have_content "Completed"
  end
end

def create_user(user, password)
  visit "/users/new"
  fill_in "Username", with: user
  fill_in "Password", with: password
  click_button "Create User"
end

def create_goal(body, private_goal = false)
  visit "/goals/new"
  fill_in "Body", with: body
  check("Private") if private_goal
  click_button("Submit Goal")
end
