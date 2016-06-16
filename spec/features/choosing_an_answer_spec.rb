require 'rails_helper'

feature "View all questions" do
  def create_questions
    Question.create(user_id: 1,
                    title: "What is the proper way to cook Chicken breasts?",
                    description: "I wasn't sure if I should defrost the chicken first or not.  If I should cook it in a pan on the stove or in a glass dish in the oven. Or if I should use any spices or not.")
  end

  def get_question_id
    question = Question.all.first
    question.id
  end

  def create_answers
    Answer.create(question_id: get_question_id,
                  user_id: 1,
                  description: "Well, considering you are my mother and I really like chicken fingers, I think that you should cut them up into long thin pieces.  Roll them in bread crumbs and cook them in the oven.",
                  best_answer: true)
    Answer.create(question_id: get_question_id, user_id: 1, description: "If you are cooking it in a pan on the stovetop, be sure to do 2 things. First, make sure that you let the pan heat up by keeping it on high heat for a minute or so. Then add some olive oil before you put the chicken in the pan. These two steps will ensure that the chicken doesn't stick to the pan.")
  end

  def navigate_to_question_details_page
    create_questions
    create_answers
    visit "/"
    click_link("What is the proper way to cook Chicken breasts?")

    # need to add some kind of test here to find the right button...will need to create a button with an ID that matches the answer id
  end

  scenario "User views the best answer on the questions detail page" do
    navigate_to_question_details_page

    expect(page).to have_content "Best Answer"
  end

  scenario "User can choose which answer is the best answer" do
    navigate_to_question_details_page
    click_link("Best Answer")

    expect(page).to have_css(".best-answer", text: "If you are cooking it in a pan")
  end

  scenario "The top answer is the first answer listed in the list of answers" do
    navigate_to_question_details_page

    expect(page).to have_css(".best-answer", text: "Well, considering you are my mother")
    expect(page).to have_selector("tr td:nth-child(2)", text: "If you are cooking it in a pan")
  end
end
