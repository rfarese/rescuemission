require 'rails_helper'

feature "Prevent Users from editing other users questions" do
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

  def create_second_user
    User.create(
      provider: 'twitter',
      uid: "165243",
      name: "Trey Farese",
      token: "15432",
      secret: "treysecret",
      profile_image: "http://img1.jurko.net/Godfather-Avatar2.gif"
    )
  end

  def get_second_user_id
    second_user = User.where(name: "Trey Farese").last
    second_user.id
  end

  def create_questions
    Question.create(user_id: get_second_user_id,
                    title: "What is the proper way to cook Chicken breasts?",
                    description: "I wasn't sure if I should defrost the chicken first or not.  If I should cook it in a pan on the stove or in a glass dish in the oven. Or if I should use any spices or not.")

    Question.create(user_id: user.id,
                    title: "What is the best way for me to get to Thomas Land?",
                    description: "Trying to get to Thomas Land when you are only 3 yrs old can be tough.  Should I ask my parents to drive me?  Or perhaps my grandpa?  Am I too hung to try and hitch hike there?")
  end

  def sign_in_and_navigate_to_edit_question_page
    create_second_user
    create_questions
    visit '/'
    sign_in_as user
    click_link("What is the proper way to cook Chicken breasts?")
    click_link("Edit Question")
  end

  scenario "A user must be signed in to edit a question" do
    create_second_user
    create_questions
    visit '/'
    click_link("What is the proper way to cook Chicken breasts?")
    click_link("Edit Question")

    fill_in("Title", with: "What is the best way to cook Chicken breasts?")
    click_button("Save Question")

    expect(page).to have_content("You must be signed in to edit a question")
    expect(page).to_not have_content("What is the best way to cook Chicken breasts?")
  end

  scenario "A signed in user successfully edits thier own question" do
    create_second_user
    create_questions
    visit '/'
    sign_in_as user
    click_link("What is the best way for me to get to Thomas Land?")
    click_link("Edit Question")

    fill_in("Title", with: "What is the proper way for me to get to Thomas Land?")
    click_button("Save Question")

    expect(page).to have_content("Signed in as bobby")
    expect(page).to have_content("What is the proper way for me to get to Thomas Land?")
  end

  scenario "A signed in user can not edit someone elses question" do
    create_second_user
    create_questions
    visit '/'
    sign_in_as user
    click_link("What is the proper way to cook Chicken breasts?")
    click_link("Edit Question")

    fill_in("Title", with: "What is the best way to cook Chicken breasts?")
    click_button("Save Question")

    expect(page).to have_content("Signed in as bobby")
    expect(page).to have_content("You can only use edit for questions you've created.")
    expect(page).to_not have_content("What is the best way to cook Chicken breasts?")
  end
end
