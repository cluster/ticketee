require 'spec_helper'

feature "hidden links" do
  let(:user){ FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:user_admin) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, user: user) }
  context "anonymous users" do
    scenario "cannot see the New Project link" do
      visit "/"
      assert_no_link_for 'New project'
    end
    scenario "cannot see the edit project link" do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end
    scenario "cannot see the delete project link" do
      visit project_path(project)
      assert_no_link_for "Delete Project"
    end
  end
  context "regular users" do
    before { sign_in_as!(user) }
    scenario "cannot see the New Project link" do
      visit "/"
      assert_no_link_for 'New project'
    end
    scenario "cannot see the edit project link" do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end
    scenario "cannot see the delete project link" do
      visit project_path(project)
      assert_no_link_for "Delete Project"
    end
    scenario "new ticket link is shown to a user with permission" do
      define_permission!(user, "view", project)
      define_permission!(user, "create tickets", project)
      visit project_path(project)
      assert_link_for "New Ticket"
    end
    scenario "new ticket link is hidden from a user without permission" do
      define_permission!(user, "view", project)
      visit project_path(project)
      assert_no_link_for "New Ticket"
    end
    scenario "edit ticket link is shown to a user with permission" do
      ticket
      define_permission!(user, "view", project)
      define_permission!(user, "edit tickets", project)
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Edit Ticket"
    end
    scenario "edit ticket link is hidden from a user without permission" do
      ticket
      define_permission!(user, "view", project)
      visit project_path(project)
      click_link ticket.title
      assert_no_link_for "Edit Ticket"
    end
    scenario "delete ticket link is shown to a user with permission" do
      ticket
      define_permission!(user, "view", project)
      define_permission!(user, "delete tickets", project)
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Delete Ticket"
    end
    scenario "delete ticket link is hidden from a user without permission" do
      ticket
      define_permission!(user, "view", project)
      visit project_path(project)
      click_link ticket.title
      assert_no_link_for "Delete Ticket"
    end
  end
  context "admin users" do
    before { sign_in_as!(admin) }
    scenario "can see the New Project link" do
      visit "/"
      assert_link_for 'New project'
    end
    scenario "can see the edit project link" do
      visit project_path(project)
      assert_link_for "Edit Project"
    end
    scenario "can see the delete project link" do
      visit project_path(project)
      assert_link_for "Delete Project"
    end
    scenario "new ticket link is shown to a user with permission" do
      visit project_path(project)
      assert_link_for "New Ticket"
    end
    scenario "edit ticket link is shown to a user with permission" do
      ticket
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Edit Ticket"
    end
    scenario "new ticket link is shown to a user with permission" do
      ticket
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Delete Ticket"
    end
  end
end
