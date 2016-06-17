require 'rails_helper'

feature "Prevent Users from deleting other users questions" do
  let(:user) do
    create_current_user
  end

  def get_user_id(name)
    User.where(name: name).first.id
  end

  def create_questions
    Question.create(user_id: get_user_id("Trey Farese"),
                    title: "What is the proper way to cook Chicken breasts?",
                    description: "I wasn't sure if I should defrost the chicken first or not.  If I should cook it in a pan on the stove or in a glass dish in the oven. Or if I should use any spices or not.")

    Question.create(user_id: user.id,
                    title: "What is the best way for me to get to Thomas Land?",
                    description: "Trying to get to Thomas Land when you are only 3 yrs old can be tough.  Should I ask my parents to drive me?  Or perhaps my grandpa?  Am I too hung to try and hitch hike there?")
  end

  scenario "A user must be signed in to delete a question" do
    create_second_user
    create_questions
    visit '/'
    click_link("What is the proper way to cook Chicken breasts?")
    click_link("Delete Question")

    expect(page).to have_content("You must be signed in to delete a question.")
    expect(page).to have_content("What is the proper way to cook Chicken breasts?")
  end

  scenario "A signed in user successfully deletes thier own question" do
    create_second_user
    create_questions
    visit '/'
    sign_in_as user
    click_link("What is the best way for me to get to Thomas Land?")
    click_link("Delete Question")

    expect(page).to have_content("Your question has been deleted.")
  end

  scenario "A signed in user can not delete someone elses question" do
    create_second_user
    create_questions
    visit '/'
    sign_in_as user
    click_link("What is the proper way to cook Chicken breasts?")
    click_link("Delete Question")

    expect(page).to have_content("You can only use delete for questions you've created.")
  end
end
