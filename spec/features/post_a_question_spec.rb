require 'rails_helper'

feature "A user creates a new question" do
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

  def sign_in_and_go_to_new_question_page
    visit "/"
    sign_in_as user
    click_link "Create a New Question"
  end

  scenario "User navigates to new questions page" do
    visit "/"
    click_link "Create a New Question"

    expect(page).to have_content "Title"
    expect(page).to have_content "Description"
  end

  scenario "User successfully creates a new question" do
    sign_in_and_go_to_new_question_page

    fill_in("Title", with: "What is the proper way to cook Chicken breasts?")
    fill_in("Description", with: "I wasn't sure if I should defrost the chicken first or not.  If I should cook it in a pan on the stove or in a glass dish in the oven. Or if I should use any spices or not.")
    click_button("Save Question")

    expect(page).to have_content "You Successfully Created Your New Question!"
  end

  scenario "User is not signed in and tries creates a new question" do
    visit "/"
    click_link "Create a New Question"
    fill_in("Title", with: "What is the proper way to cook Chicken breasts?")
    fill_in("Description", with: "I wasn't sure if I should defrost the chicken first or not.  If I should cook it in a pan on the stove or in a glass dish in the oven. Or if I should use any spices or not.")
    click_button("Save Question")

    expect(page).to have_content "You must be signed in to create a new question"
  end

  scenario "User is signed in but provides a title that is too short" do
    sign_in_and_go_to_new_question_page

    fill_in("Title", with: "What is a chicken?")
    fill_in("Description", with: "I wasn't sure if I should defrost the chicken first or not.  If I should cook it in a pan on the stove or in a glass dish in the oven. Or if I should use any spices or not.")
    click_button("Save Question")

    expect(page).to have_content "1 error stopped this question from being saved:"
    expect(page).to have_content "Title is too short (minimum is 40 characters)"
  end

  scenario "User is signed in but provides a description that is too short" do
    sign_in_and_go_to_new_question_page

    fill_in("Title", with: "What is the proper way to cook Chicken breasts?")
    fill_in("Description", with: "Should I use any spices?")
    click_button("Save Question")

    expect(page).to have_content "1 error stopped this question from being saved:"
    expect(page).to have_content "Description is too short (minimum is 150 characters)"
  end

  scenario "User is signed in but provides a description and a title that is too short" do
    sign_in_and_go_to_new_question_page

    fill_in("Title", with: "What is a chicken?")
    fill_in("Description", with: "Should I use any spices?")
    click_button("Save Question")

    expect(page).to have_content "2 errors stopped this question from being saved:"
    expect(page).to have_content "Title is too short (minimum is 40 characters)"
    expect(page).to have_content "Description is too short (minimum is 150 characters)"
  end
end
