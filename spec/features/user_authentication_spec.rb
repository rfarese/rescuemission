require 'rails_helper'

feature "User authentication" do
  let(:user) do
    User.create(
      provider: "twitter",
      uid: "uid1",
      name: "bobby",
      token: "1234",
      secret: "abigsecret",
      profile_image: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

  scenario "A user must be able to sign in with Twitter" do
    visit "/"
    sign_in_as user

    expect(page).to have_content("Signed in as bobby")
    expect(user.provider).to eq("twitter")
  end
end
