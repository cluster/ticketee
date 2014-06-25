require 'spec_helper'

feature "creating users" do
  let!(:admin){ FactoryGirl.create(:user_admin) }
  before do
    sign_in_as!(admin)
    visit '/'
    click_link "Admin"
    click_link "Users"
    click_link "New User"
  end
  scenario "creating a new user" do
    fill_in "Email", with: "newbie@example.com"
    fill_in "Password", with: "password"
    click_button "Create User"

    expect(page).to have_content("User has been created.")
  end
  scenario "creating an admin user" do
    fill_in "Email", with: "admin@example.com"
    fill_in "Password", with: "password"
    check "Is an admin?"
    click_button "Create User"

    expect(page).to have_content("User has been created.")
    within("#users") do
      expect(page).to have_content("admin@example.com (Admin)")
    end
  end
end
