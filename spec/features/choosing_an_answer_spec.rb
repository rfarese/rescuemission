require 'rails_helper'

feature "User can choose a best answer" do
  let(:user) do
    create_current_user
  end

  def create_answers
    Answer.create(question_id: Question.all.first.id,
                  user_id: 1,
                  description: "Well, considering you are my mother and I really like chicken fingers, I think that you should cut them up into long thin pieces.  Roll them in bread crumbs and cook them in the oven.",
                  best_answer: true)
    Answer.create(question_id: Question.all.first.id, user_id: 1, description: "If you are cooking it in a pan on the stovetop, be sure to do 2 things. First, make sure that you let the pan heat up by keeping it on high heat for a minute or so. Then add some olive oil before you put the chicken in the pan. These two steps will ensure that the chicken doesn't stick to the pan.")
  end

  def navigate_to_question_details_page
    create_current_user_question
    create_answers
    visit "/"
    sign_in_as user
    click_link("What is the proper way to cook Chicken breasts?")
  end

  scenario "User views the best answer on the questions detail page" do
    navigate_to_question_details_page

    expect(page).to have_content "Best Answer"
    expect(page).to have_content "Set New Best Answer"
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
