class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def create
    if !current_user
      flash[:notice] = "You must be signed in to create a new question"
      render 'new'
    else
      title = question_params[:title]
      description = question_params[:description]

      @question = Question.create(user_id: current_user.id, title: title, description: description)

      if @question.save
        flash[:notice] = "You Successfully Created Your New Question!"
        redirect_to @question
      else
        render 'new'
      end
    end
  end

  def update
    @question = Question.find(params[:id])

    if !current_user
      flash[:notice] = "You must be signed in to edit a question"
      redirect_to edit_question_path(params[:id])
    elsif current_user.id != @question.user_id
      flash[:notice] = "You can only edit your own questions."
      redirect_to edit_question_path(params[:id])
    else
      if @question.update(question_params)
        redirect_to @question
      else
        render 'edit'
      end
    end
  end

  def destroy
    @question = Question.find(params[:id])

    if !current_user
      flash[:notice] = "You must be signed in to delete a question."
      redirect_to @question
    elsif current_user.id != @question.user_id
      flash[:notice] = "You can only delete a question you've created."
      redirect_to @question
    else
      @question.destroy
      answers = Answer.where(question_id: @question.id)
      answers.delete_all
      flash[:notice] = "Your question has been deleted."

      redirect_to questions_path
    end
  end

  private
    def question_params
      params.require(:question).permit(:title, :description)
    end
end
