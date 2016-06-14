require 'rails_helper'

feature "A user views a questions answers" do
  let(:user) do
    User.create(
      provider: "Provider1",
      uid: "uid1",
      name: "bobby",
      token: "1234",
      secret: "abigsecret",
      profile_image: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

  def create_question
    Question.create(user_id: 1,
                    title: "What is the proper way to cook Chicken breasts?",
                    description: "I wasn't sure if I should defrost the chicken first or not.  If I should cook it in a pan on the stove or in a glass dish in the oven. Or if I should use any spices or not.")
  end

  def create_answers
    Answer.create(question_id: 1, user_id: 1, description: "Well, considering you are my mother and I really like chicken fingers, I think that you should cut them up into long thin pieces.  Roll them in bread crumbs and cook them in the oven.")
    Answer.create(question_id: 1, user_id: 1, description: "If you are cooking it in a pan on the stovetop, be sure to do 2 things. First, make sure that you let the pan heat up by keeping it on high heat for a minute or so. Then add some olive oil before you put the chicken in the pan. These two steps will ensure that the chicken doesn't stick to the pan.")
  end

  def navigate_to_question_detail_page
      create_question
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
    create_question
    Answer.create(question_id: 2, user_id: 1, description: "Well, considering you are my mother and I really like chicken fingers, I think that you should cut them up into long thin pieces.  Roll them in bread crumbs and cook them in the oven.")
    Answer.create(question_id: 2, user_id: 1, description: "If you are cooking it in a pan on the stovetop, be sure to do 2 things. First, make sure that you let the pan heat up by keeping it on high heat for a minute or so. Then add some olive oil before you put the chicken in the pan. These two steps will ensure that the chicken doesn't stick to the pan.")
    visit "/"
    click_link "What is the proper way to cook Chicken breasts?"

    expect(page).to have_content "Well, considering you are my mother and I really like chicken fingers, I think that you should cut them up into long thin pieces.  Roll them in bread crumbs and cook them in the oven."
  end

  scenario "The user must see all the answers in chronological order" do
    create_question
    Answer.create(question_id: 3, user_id: 1, description: "Well, considering you are my mother and I really like chicken fingers, I think that you should cut them up into long thin pieces.  Roll them in bread crumbs and cook them in the oven.")
    Answer.create(question_id: 3, user_id: 1, description: "If you are cooking it in a pan on the stovetop, be sure to do 2 things. First, make sure that you let the pan heat up by keeping it on high heat for a minute or so. Then add some olive oil before you put the chicken in the pan. These two steps will ensure that the chicken doesn't stick to the pan.")
    visit "/"
    click_link "What is the proper way to cook Chicken breasts?"

    expect(page).to have_selector("ul li:nth-child(1)", text: "Well, considering")
    expect(page).to have_selector("ul li:nth-child(2)", text: "If you are")
  end
end