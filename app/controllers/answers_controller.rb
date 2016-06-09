class AnswersController < ApplicationController
  def create
    user_id = session[:user_id]
    question_id = params[:question_id]

    @question = Question.find(question_id)
    @answer = @question.answers.create(question_id: question_id, user_id: user_id, description: answer_params["description"])

    if !@answer.valid?
      flash[:notice] = "An Answer must be atleast 50 characters long.  Try again."
    end

    redirect_to question_path(question_id)
  end

  private
    def answer_params
      params.require(:answer).permit(:description)
    end
end
