require_relative '../spec_helper'

feature "View all questions", :type => :feature do

  def create_user
    User.create(
      provider: "Provider1",
      uid: "uid1",
      name: "bobby",
      token: "1234",
      secret: "abigsecret",
      profile_image: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

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

    expect(page).to have_content "Should not pass"
    expect(page).to have_content "Should certainly not pass"
    expect(page).to have_content "Should really certainly not pass"
  end
end
#
# - I must see the title of each question
# - I must see questions listed in order, most recently posted first
