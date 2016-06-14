require 'pry'

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
    if session[:user_id] == nil
      flash[:notice] = "You must be signed in to create a new question"
      render 'new'
    else
      user_id = session[:user_id]
      title = question_params[:title]
      description = question_params[:description]

      @question = Question.create(user_id: user_id, title: title, description: description)

      if @question.save
        flash[:notice] = "You Successfully Created Your New Question!"
        redirect_to @question
      else
        render 'new'
      end
    end
  end

  def update
    if session[:user_id] == nil
      flash[:notice] = "You must be signed in to edit a question"
    end

    @question = Question.find(params[:id])

    title = question_params[:title]
    description = question_params[:description]

    if @question.update(question_params)
      redirect_to @question
    else
      render 'edit'
    end
  end

  private
    def question_params
      params.require(:question).permit(:title, :description)
    end
end
