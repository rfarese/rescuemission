require 'rails_helper'

feature "View all questions" do
  def create_questions
    Question.create(user_id: 1,
                    title: "What is the proper way to cook Chicken breasts?",
                    description: "I wasn't sure if I should defrost the chicken first or not.  If I should cook it in a pan on the stove or in a glass dish in the oven. Or if I should use any spices or not.")
    Question.create(user_id: 2,
                    title: "What is the best way for me to get to Thomas Land?",
                    description: "Trying to get to Thomas Land when you are only 3 yrs old can be tough.  Should I ask my parents to drive me?  Or perhaps my grandpa?  Am I too hung to try and hitch hike there?")
    Question.create(user_id: 3,
                    title: "How do I get my older brother to stop taking all my toys all the time?",
                    description: "Because I am not even 2 yrs old yet, my older brother is a lot stronger than I am and is always taking my toys.  Is there any way I can stop his seeminly unstoppable toy confiscating abilities?")
  end

  def create_answers
    Answer.create(question_id: 1, user_id: 1, description: "Well, considering you are my mother and I really like chicken fingers, I think that you should cut them up into long thin pieces.  Roll them in bread crumbs and cook them in the oven.")
    Answer.create(question_id: 1, user_id: 1, description: "If you are cooking it in a pan on the stovetop, be sure to do 2 things. First, make sure that you let the pan heat up by keeping it on high heat for a minute or so. Then add some olive oil before you put the chicken in the pan. These two steps will ensure that the chicken doesn't stick to the pan.")
  end

  scenario "User views the best answer on the questions detail page" do
    create_questions
    visit "/"

    expect(page).to have_content "Best Answer"
    expect(page).to have_selector("ul li:nth-child(1)", text: "this shouldn't pass")
  end

  scenario "User can choose which answer is the best answer" do
    create_questions
    visit "/"

    expect(page).to have_content "this shouldn't pass"
    expect(page).to have_selector("ul li:nth-child(1)", text: "this shouldn't pass")
  end

  scenario "The top answer is the first answer listed in the list of answers" do
    create_questions
    visit "/"

    expect(page).to have_content "this shouldn't pass"
    expect(page).to have_selector("ul li:nth-child(1)", text: "this shouldn't pass")
  end
end
