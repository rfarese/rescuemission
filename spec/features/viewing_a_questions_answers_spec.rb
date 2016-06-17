require 'rails_helper'

feature "A user views a questions answers" do
  let(:user) do
    create_current_user
  end

  def create_answers
    Answer.create(question_id: Question.all.first.id, user_id: 1, description: "Well, considering you are my mother and I really like chicken fingers, I think that you should cut them up into long thin pieces.  Roll them in bread crumbs and cook them in the oven.")
    Answer.create(question_id: Question.all.first.id, user_id: 1, description: "If you are cooking it in a pan on the stovetop, be sure to do 2 things. First, make sure that you let the pan heat up by keeping it on high heat for a minute or so. Then add some olive oil before you put the chicken in the pan. These two steps will ensure that the chicken doesn't stick to the pan.")
  end

  def navigate_to_question_detail_page
      create_current_user_question
      create_answers
      visit "/"
      click_link "What is the proper way to cook Chicken breasts?"
  end

  scenario "User must be viewing answers on the questions detail page" do
    navigate_to_question_detail_page

    expect(page).to have_content "What is the proper way to cook Chicken breasts?"
    expect(page).to have_content "I wasn't sure if I should defrost the chicken first or not.  If I should cook it in a pan on the stove or in a glass dish in the oven. Or if I should use any spices or not."
  end

  scenario "Must only be seeing answers to the question they are viewing" do
    navigate_to_question_detail_page

    expect(page).to have_content "Well, considering you are my mother and I really like chicken fingers, I think that you should cut them up into long thin pieces.  Roll them in bread crumbs and cook them in the oven."
  end

  scenario "The user must see all the answers in chronological order" do
    navigate_to_question_detail_page

    expect(page).to have_css("tr td:nth-child(2)", text: "Well, considering")
    expect(page).to have_selector("tr td:last-child", text: "If you are cooking")
  end
end
