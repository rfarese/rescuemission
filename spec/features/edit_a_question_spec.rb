require 'rails_helper'

feature "A user edits a question" do
  let(:user) do
    create_current_user
  end

  def navigate_to_question_edit_page
      create_current_user_question
      visit "/"
      sign_in_as user
      click_link "What is the proper way to cook Chicken breasts?"
      click_link "Edit Question"
  end

  scenario "User must get to the edit page from the questions details page" do
    create_current_user_question
    visit '/'
    click_link "What is the proper way to cook Chicken breasts?"

    expect(page).to have_content "Edit Question"
  end

  scenario "User provides a title that is too short" do
    navigate_to_question_edit_page

    fill_in("Title", with: "What is a chicken?")
    fill_in("Description", with: "I wasn't sure if I should defrost the chicken first or not.  If I should cook it in a pan on the stove or in a glass dish in the oven. Or if I should use any spices or not.")
    click_button("Update Question")

    expect(page).to have_content "1 error stopped this question from being saved:"
    expect(page).to have_content "Title is too short (minimum is 40 characters)"
  end

  scenario "User provides a description that is too short" do
    navigate_to_question_edit_page

    fill_in("Title", with: "What is the proper way to cook Chicken breasts?")
    fill_in("Description", with: "Should I use any spices?")
    click_button("Update Question")

    expect(page).to have_content "1 error stopped this question from being saved:"
    expect(page).to have_content "Description is too short (minimum is 150 characters)"
  end

  scenario "User successfully edits a question" do
    navigate_to_question_edit_page

    fill_in("Title", with: "What is the best way to cook Chicken breasts?")
    fill_in("Description", with: "I wasn't sure if I should defrost the chicken first or not.  If I should cook it in a pan on the stove or in a glass dish in the oven. Or if I should use any spices or not.")
    click_button("Update Question")

    expect(page).to have_content "What is the best way to cook Chicken breasts?"
    expect(page).to have_content "Your question has been updated."
  end
end
