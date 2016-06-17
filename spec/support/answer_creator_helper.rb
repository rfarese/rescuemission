module AnswerCreatorHelper

  def get_user_id(name)
    User.where(name: name).first.id
  end

  def third_user_answers_current_users_question
    Answer.create(question_id: Question.all.first.id, user_id: get_user_id("Declan Farese"), description: "Well, considering you are my mother and I really like chicken fingers, I think that you should cut them up into long thin pieces.  Roll them in bread crumbs and cook them in the oven.")
  end

  def third_user_answers_second_users_question
    Answer.create(question_id: Question.all.last.id, user_id: get_user_id("Declan Farese"), description: "If you are cooking it in a pan on the stovetop, be sure to do 2 things. First, make sure that you let the pan heat up by keeping it on high heat for a minute or so. Then add some olive oil before you put the chicken in the pan. These two steps will ensure that the chicken doesn't stick to the pan.")
  end
end
