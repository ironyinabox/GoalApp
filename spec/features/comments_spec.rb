
require 'spec_helper'
require 'rails_helper'

feature "comments" do
  before :each do
    create_user('batman', 'alfred')
    create_goal('wear a cape')
    create_user('robin', 'alfred')
    create_goal('wear better disguise')
  end
  feature "goals show" do
    before :each do
      visit "/goals/#{Goal.first.id}"
    end

    it "has comment fields" do
      expect(page).to have_content("Comments")
    end

    it "has submit button for comments" do
      expect(page).to have_button("Submit Comment")
    end

    it "saves comment to goal show page" do
      fill_in "Submit Comment", with: "This is a comment"
      click_button("Submit Comment")
      expect(page).to have_content "This is a comment"
    end
  end

  feature "users show" do
    before :each do
      visit "/users/#{User.first.id}"
    end

    it "has comment fields" do
      expect(page).to have_content("Comments")
    end

    it "has submit button for comments" do
      expect(page).to have_button("Submit Comment")
    end

    it "saves comment to goal show page" do
      fill_in "Submit Comment", with: "This is a comment"
      click_button("Submit Comment")
      expect(page).to have_content "This is a comment"
    end
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
