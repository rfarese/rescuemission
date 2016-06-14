require 'rails_helper'

feature "A user can use markdown" do
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

  def navigate_to_new_question_page
      visit "/"
      sign_in_as user
      click_link "Create a New Question"
  end

  def navigate_to_question_details_page
    create_question
    visit "/"
    sign_in_as user
    click_link "What is the proper way to cook Chicken breasts?"
  end

  scenario "User uses mardown when creating a new question" do
    navigate_to_new_question_page

    fill_in("Title", with: "This entire description for this question should be emphasized so that we can see that markdown is working")
    fill_in("Description", with: "*This description doesn't really mean much.  Its just a space filler to ensure that the markdown is working for users that are creating a new question.  I hope it works!*")
    click_button("Save Question")

    expect(page).to have_css("p em", text: "This description doesn't")
  end

  scenario "User uses markdown when editing a question" do
    navigate_to_question_details_page
    click_link("Edit Question")

    fill_in("Title", with: "What is the proper way to cook Chicken breasts?")
    fill_in("Description", with: "*I wasn't sure if I should defrost the chicken first or not.  If I should cook it in a pan on the stove or in a glass dish in the oven. Or if I should use any spices or not.*")
    click_button("Save Question")

    expect(page).to have_css("p em", text: "I wasn't sure")
  end

  scenario "User uses markdown when creating a new answer" do
    navigate_to_question_details_page

    fill_in("Description", with: "*This entire answer should be emphasized so that we can see that markdown is working. Let's hope that it is because that would be awesome!*")
    click_button("Create Answer")

    expect(page).to have_css("p em", text: "This entire answer")
  end
end
