require 'rails_helper'

feature "Prevent Users from editing other users questions" do
  let(:user) do
    create_current_user
  end

  def create_questions
    create_current_user_question
    create_second_user_question
  end

  def sign_in_and_navigate_to_edit_question_page(question_link)
    create_second_user
    create_questions
    visit '/'
    sign_in_as user
    click_link(question_link)
    click_link("Edit Question")
  end

  scenario "A user must be signed in to edit a question" do
    create_second_user
    create_questions
    visit '/'
    click_link("What is the proper way to cook Chicken breasts?")
    click_link("Edit Question")

    fill_in("Title", with: "What is the best way to cook Chicken breasts?")
    click_button("Update Question")

    expect(page).to have_content("You must be signed in to edit a question")
    expect(page).to_not have_content("What is the best way to cook Chicken breasts?")
  end

  scenario "A signed in user successfully edits thier own question" do
    sign_in_and_navigate_to_edit_question_page("What is the proper way to cook Chicken breasts?")

    fill_in("Title", with: "What is the best way to cook Chicken breasts?")
    click_button("Update Question")

    expect(page).to have_content("Signed in as bobby")
    expect(page).to have_content("What is the best way to cook Chicken breasts?")
  end

  scenario "A signed in user can not edit someone elses question" do
    sign_in_and_navigate_to_edit_question_page("What is the best way for me to get to Thomas Land?")

    fill_in("Title", with: "What is the proper way for me to get to Thomas Land?")
    click_button("Update Question")

    expect(page).to have_content("Signed in as bobby")
    expect(page).to have_content("You can only use edit for questions you've created.")
    expect(page).to_not have_content("What is the best way for me to get to Thomas Land?")
  end
end
