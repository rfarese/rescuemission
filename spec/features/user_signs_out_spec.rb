require 'rails_helper'

feature "User sign out" do
  let(:user) do
    User.create(
      provider: "Provider1",
      uid: "uid1",
      name: "bobby",
      token: "1234",
      secret: "abigsecret",
      profile_image: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

  scenario "A user must be able to sign out" do
    visit "/"
    sign_in_as user
    click_link("Sign Out")

    expect(page).to have_content("You have been signed out.")
  end
end
