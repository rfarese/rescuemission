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

  def create
    user_id = session[:user_id]
    title = question_params[:title]
    description = question_params[:description]

    @question = Question.create(user_id: user_id, title: title, description: description)

    if @question.save
      redirect_to @question
    else
      render 'new'
    end
  end

  private
    def question_params
      user_id = session[:user_id]

      params.require(:question).permit(:title, :description)
    end
end
