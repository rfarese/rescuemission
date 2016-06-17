require 'rails_helper'

feature "User authentication" do
  let(:user) do
    create_current_user
  end

  scenario "A user must be able to sign in with Twitter" do
    visit "/"
    sign_in_as user

    expect(page).to have_content("Signed in as bobby")
    expect(user.provider).to eq("twitter")
  end
end
