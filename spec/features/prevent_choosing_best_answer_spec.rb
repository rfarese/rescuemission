require 'rails_helper'

feature "Prevent Users from editing other users questions" do
  let(:user) do
    create_current_user
  end

  def create_more_users
    create_second_user
    create_third_user
  end

  def get_user_id(name)
    this_user = User.where(name: name).first
    this_user.id
  end

  def get_question_id
    questions = Question.all
    questions
  end

  def create_questions
    Question.create(user_id: get_user_id("Trey Farese"),
                    title: "What is the proper way to cook Chicken breasts?",
                    description: "I wasn't sure if I should defrost the chicken first or not.  If I should cook it in a pan on the stove or in a glass dish in the oven. Or if I should use any spices or not.")

    Question.create(user_id: user.id,
                    title: "What is the best way for me to get to Thomas Land?",
                    description: "Trying to get to Thomas Land when you are only 3 yrs old can be tough.  Should I ask my parents to drive me?  Or perhaps my grandpa?  Am I too hung to try and hitch hike there?")
  end

  def create_answers
    Answer.create(question_id: get_question_id.first.id, user_id: get_user_id("Declan Farese"), description: "Well, considering you are my mother and I really like chicken fingers, I think that you should cut them up into long thin pieces.  Roll them in bread crumbs and cook them in the oven.")
    Answer.create(question_id: get_question_id.last.id, user_id: get_user_id("Declan Farese"), description: "If you are cooking it in a pan on the stovetop, be sure to do 2 things. First, make sure that you let the pan heat up by keeping it on high heat for a minute or so. Then add some olive oil before you put the chicken in the pan. These two steps will ensure that the chicken doesn't stick to the pan.")
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
    click_link("What is the best way for me to get to Thomas Land?")
    click_link("Best Answer")

    expect(page).to have_content("You've added a new best answer!")
  end

  scenario "A signed in user can not choose a best answer for someone elses question" do
    create_more_users
    create_questions
    create_answers
    visit '/'
    sign_in_as user
    click_link("What is the proper way to cook Chicken breasts?")
    click_link("Best Answer")

    expect(page).to have_content("You can only choose a best answer for questions you've created.")
  end
end
