require 'spec_helper'

feature "deleting tickets" do
  let!(:project) { FactoryGirl.create(:project) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:ticket) do
    FactoryGirl.create(:ticket, project: project, user: user)
  end
  before do
    define_permission!(user, "view", project)
    define_permission!(user, "delete tickets", project)
    sign_in_as!(user)
    visit '/'
    click_link project.name
    click_link ticket.title
  end
  scenario "deleting a ticket" do
    click_link "Delete Ticket"

    expect(page).to have_content("Ticket has been deleted.")
    expect(page.current_url).to eq(project_url(project))
  end
end
