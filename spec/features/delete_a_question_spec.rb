require 'rails_helper'

feature "A user deletes a question" do
  let(:user) do
    create_current_user
  end

  def create_question
    Question.create(user_id: user.id,
                    title: "What is the proper way to cook Chicken breasts?",
                    description: "I wasn't sure if I should defrost the chicken first or not.  If I should cook it in a pan on the stove or in a glass dish in the oven. Or if I should use any spices or not.")
  end

  def get_question_id
    question = Question.all.first
    question.id
  end

  def create_answer
    Answer.create(question_id: get_question_id, user_id: 1, description: "Well, considering you are my mother and I really like chicken fingers, I think that you should cut them up into long thin pieces.  Roll them in bread crumbs and cook them in the oven.")
  end

  def navigate_to_question_details_page
      create_question
      visit "/"
      sign_in_as user
      click_link "What is the proper way to cook Chicken breasts?"
  end

  scenario "User can delete a question on the question edit page" do
    navigate_to_question_details_page
    click_link "Edit Question"
    click_link "Delete Question"

    expect(page).not_to have_content "What is the proper way to cook Chicken breasts?"
  end

  scenario "User can delete a question on the questions details page" do
    navigate_to_question_details_page
    click_link "Delete Question"

    expect(page).not_to have_content "What is the proper way to cook Chicken breasts?"
  end

  scenario "All answers associated with a question will be deleted along with the question itself" do
    create_question
    create_answer
    visit "/"
    sign_in_as user
    click_link "What is the proper way to cook Chicken breasts?"
    click_link "Delete Question"
    answer = Answer.all.first

    expect(answer).to equal(nil)
  end
end
