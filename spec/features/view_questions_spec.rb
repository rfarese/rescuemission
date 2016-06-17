require 'rails_helper'

feature "View all questions" do
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
    create_third_user_question
  end

  scenario "User views the title of each question" do
    create_more_users
    create_questions
    visit "/"

    expect(page).to have_content "What is the proper way to cook Chicken breasts?"
    expect(page).to have_content "What is the best way for me to get to Thomas Land?"
    expect(page).to have_content "How do I get my older brother to stop taking all my toys all the time?"
    expect(page).to have_selector("ul li:nth-child(1)", text: "What is the proper way to cook Chicken breasts?")
  end
end
