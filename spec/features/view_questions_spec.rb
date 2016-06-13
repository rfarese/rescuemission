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

  scenario "User views the title of each question" do
    create_questions
    visit "/"

    expect(page).to have_content "What is the proper way to cook Chicken breasts?"
    expect(page).to have_content "What is the best way for me to get to Thomas Land?"
    expect(page).to have_content "How do I get my older brother to stop taking all my toys all the time?"
    expect(page).to have_selector("ul li:nth-child(1)", text: "What is the proper way to cook Chicken breasts?")
  end
end
