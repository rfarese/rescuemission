require 'rails_helper'

feature "A user answers a question" do
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

  def create_question
    Question.create(user_id: 1,
                    title: "What is the proper way to cook Chicken breasts?",
                    description: "I wasn't sure if I should defrost the chicken first or not.  If I should cook it in a pan on the stove or in a glass dish in the oven. Or if I should use any spices or not.")
  end

  def sign_in_and_go_to_question_detail_page
      create_question
      visit "/"
      sign_in_as user
      click_link "What is the proper way to cook Chicken breasts?"
  end

  scenario "User must be answering the question on the questions detail page" do
    sign_in_and_go_to_question_detail_page
    
    expect(page).to have_content "I wasn't sure if I should defrost the chicken first or not. If I should cook it in a pan on the stove or in a glass dish in the oven. Or if I should use any spices or not."
    expect(page).to have_content "Add an Answer:"
    expect(page).to have_button "Create Answer"
  end

  scenario "User provides a description that is too short" do
    sign_in_and_go_to_question_detail_page

    fill_in("Description", with: "I don't like chicken.")
    click_button("Create Answer")

    expect(page).to have_content "An Answer must be atleast 50 characters long. Try again."
  end

  scenario "User successfully answers a question" do
    sign_in_and_go_to_question_detail_page

    fill_in("Description", with: "It really depends on what you want to accomplish.  What type of chicken dish would you like to make?  You can make chicken with pasta, you can make chicken by itself and add veggies on the side.  There are a million ways to cook chicken.")
    click_button("Create Answer")

    expect(page).to have_content "It really depends on what you want to accomplish.  What type of chicken dish would you like to make?  You can make chicken with pasta, you can make chicken by itself and add veggies on the side.  There are a million ways to cook chicken."
  end
end
