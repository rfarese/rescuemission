class QuestionsController < ApplicationController
  def find_question
    Question.find(params[:id])
  end

  def index
    @questions = Question.all
  end

  def show
    @question = find_question
  end

  def new
    @question = Question.new
  end

  def edit
    @question = find_question
  end

  def create
    user_not_signed_in_notice("create a new question", new_question_path)

    if current_user
      @question = Question.create(question_params)

      if @question.save
        flash[:notice] = "You Successfully Created Your New Question!"
        redirect_to @question
      else
        render 'new'
      end
    end
  end

  def update
    @question = find_question

    user_not_signed_in_notice("edit a question", edit_question_path(params[:id]))
    not_your_question_notice("use edit", edit_question_path(params[:id])) if current_user

    if current_user && current_user.id == @question.user_id
      if @question.update(question_params)
        flash[:notice] = "Your question has been updated."

        redirect_to @question
      else
        render 'edit'
      end
    end
  end

  def destroy
    @question = find_question

    user_not_signed_in_notice("delete a question", @question)
    not_your_question_notice("use delete", @question) if current_user

    if current_user && current_user.id == @question.user_id
      @question.destroy
      answers = Answer.where(question_id: @question.id)
      answers.delete_all
      flash[:notice] = "Your question has been deleted."

      redirect_to questions_path
    end
  end

  private
    def question_params
      params_hash = params.require(:question).permit(:title, :description)
      new_hash = { user_id: current_user.id }
      new_hash.merge!(params_hash)
    end
end
