module QuestionCreatorHelper
  def get_user_id(name)
    User.where(name: name).first.id
  end

  def create_current_user_question
    Question.create(user_id: user.id,
                    title: "What is the proper way to cook Chicken breasts?",
                    description: "I wasn't sure if I should defrost the chicken first or not.  If I should cook it in a pan on the stove or in a glass dish in the oven. Or if I should use any spices or not.")
  end

  def create_second_user_question
    Question.create(user_id: get_user_id("Trey Farese"),
                    title: "What is the best way for me to get to Thomas Land?",
                    description: "Trying to get to Thomas Land when you are only 3 yrs old can be tough.  Should I ask my parents to drive me?  Or perhaps my grandpa?  Am I too hung to try and hitch hike there?")
  end

  def create_third_user_question
    Question.create(user_id: get_user_id("Declan Farese"),
                    title: "How do I get my older brother to stop taking all my toys all the time?",
                    description: "Because I am not even 2 yrs old yet, my older brother is a lot stronger than I am and is always taking my toys.  Is there any way I can stop his seeminly unstoppable toy confiscating abilities?")
  end
end
