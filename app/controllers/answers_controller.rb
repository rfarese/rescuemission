class AnswersController < ApplicationController
  def find_question
    Question.find(params[:question_id])
  end

  def create
    @question = find_question

    user_not_signed_in_notice("create a new answer", question_path(@question))

    if current_user
      @answer = @question.answers.create(question_id: @question.id, user_id: current_user.id, description: answer_params["description"])
      if !@answer.valid?
        flash[:notice] = "An Answer must be atleast 50 characters long.  Try again."
      end
      redirect_to question_path(@question)
    end
  end

  def best_answers_to_false(answers)
    answers.each do |answer|
      answer.best_answer = false
      answer.save
    end
  end

  def change_current_best_answer(question_id)
    answers = Answer.where(question_id: question_id, best_answer: true)

    best_answers_to_false(answers) if answers
  end

  def update
    @question = find_question

    user_not_signed_in_notice("choose a best answer", @question)
    not_your_question_notice("choose a best answer", @question) if current_user

    if current_user && current_user.id == @question.user_id
      change_current_best_answer(@question.id)
      answer = Answer.where(id: params[:id]).first
      answer.best_answer = true

      if answer.save
        flash[:notice] = "You've added a new best answer!"
        redirect_to @question
      else
        render 'edit'
      end
    end
  end

  def destroy
    @question = find_question
    @answer = @question.answers.find(params[:id])
    @answer.destroy

    redirect_to question_path(@answer)
  end

  private
    def answer_params
      params.require(:answer).permit(:description)
    end
end
