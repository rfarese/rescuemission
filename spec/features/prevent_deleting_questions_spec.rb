require 'rails_helper'

feature "Prevent Users from deleting other users questions" do
  let(:user) do
    create_current_user
  end

  def create_questions
    create_current_user_question
    create_second_user_question
  end

  scenario "A user must be signed in to delete a question" do
    create_second_user
    create_questions
    visit '/'
    click_link("What is the proper way to cook Chicken breasts?")
    click_link("Delete Question")

    expect(page).to have_content("You must be signed in to delete a question.")
    expect(page).to have_content("What is the proper way to cook Chicken breasts?")
  end

  scenario "A signed in user successfully deletes thier own question" do
    create_second_user
    create_questions
    visit '/'
    sign_in_as user
    click_link("What is the proper way to cook Chicken breasts?")
    click_link("Delete Question")

    expect(page).to have_content("Your question has been deleted.")
  end

  scenario "A signed in user can not delete someone elses question" do
    create_second_user
    create_questions
    visit '/'
    sign_in_as user
    click_link("What is the best way for me to get to Thomas Land?")
    click_link("Delete Question")

    expect(page).to have_content("You can only use delete for questions you've created.")
  end
end
