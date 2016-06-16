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

  def change_current_best_answer(question_id)
    if Answer.where(question_id: question_id, best_answer: true)
      answers = Answer.where(question_id: question_id, best_answer: true)

      answers.each do |answer|
        answer.best_answer = false
        answer.save
      end
    end
  end

  def update
    @question = Question.find(params[:question_id])
    change_current_best_answer(params[:question_id])

    answer_id = params[:id]
    answer = Answer.where(id: answer_id).first
    answer.best_answer = true

    if answer.save
      redirect_to @question
    else
      render 'edit'
    end
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
