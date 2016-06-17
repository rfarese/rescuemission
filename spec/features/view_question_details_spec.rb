require 'rails_helper'

feature "View a questions details" do
  let(:user) do
    create_current_user
  end

  def create_questions
    create_current_user_question
  end

  scenario "User views the title and description of each question" do
    create_questions
    visit "/"
    click_link("What is the proper way to cook Chicken breasts?")

    expect(page).to have_content "What is the proper way to cook Chicken breasts?"
    expect(page).to have_content "I wasn't sure if I should defrost the chicken first or not.  If I should cook it in a pan on the stove or in a glass dish in the oven. Or if I should use any spices or not."
  end
end
