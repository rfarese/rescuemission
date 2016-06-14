class AnswersController < ApplicationController
  def create
    user_id = session[:user_id]
    question_id = params[:question_id]
    @question = Question.find(question_id)

    if session[:user_id] == nil
      flash[:notice] = "You must be signed in to create a new question"
    else
      @answer = @question.answers.create(question_id: question_id, user_id: user_id, description: answer_params["description"])
      if !@answer.valid?
        flash[:notice] = "An Answer must be atleast 50 characters long.  Try again."
      end
    end

    redirect_to question_path(question_id)
  end

  def destroy
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
    @answer.destroy

    redirect_to question_path(@answer)
  end

  private
    def answer_params
      params.require(:answer).permit(:description)
    end
end
