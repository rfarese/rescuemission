require 'rails_helper'

feature "User sign out" do
  let(:user) do
    create_current_user
  end

  scenario "A user must be able to sign out" do
    visit "/"
    sign_in_as user
    click_link("Sign Out")

    expect(page).to have_content("You have been signed out.")
  end
end
