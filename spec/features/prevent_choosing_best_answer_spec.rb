require 'rails_helper'

feature "Prevent Users from editing other users questions" do
  let(:user) do
    create_current_user
  end

  def create_more_users
    create_second_user
    create_third_user
  end

  def create_questions
    create_current_user_question
    create_second_user_question
  end

  def create_answers
    third_user_answers_current_users_question
    third_user_answers_second_users_question
  end

  scenario "A user must be signed in to choose a best answer" do
    create_more_users
    create_questions
    create_answers
    visit '/'
    click_link("What is the proper way to cook Chicken breasts?")
    click_link("Best Answer")

    expect(page).to have_content("You must be signed in to choose a best answer.")
  end

  scenario "A signed in user successfully edits thier own question" do
    create_more_users
    create_questions
    create_answers
    visit '/'
    sign_in_as user
    click_link("What is the proper way to cook Chicken breasts?")
    click_link("Best Answer")

    expect(page).to have_content("You've added a new best answer!")
  end

  scenario "A signed in user can not choose a best answer for someone elses question" do
    create_more_users
    create_questions
    create_answers
    visit '/'
    sign_in_as user
    click_link("What is the best way for me to get to Thomas Land?")
    click_link("Best Answer")

    expect(page).to have_content("You can only choose a best answer for questions you've created.")
  end
end
