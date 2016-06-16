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
    @question = Question.find(params[:id])

    if session[:user_id] == nil
      flash[:notice] = "You must be signed in to edit a question"
      redirect_to edit_question_path(params[:id])
    elsif session[:user_id] != @question.user_id
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
    @question.destroy
    answers = Answer.where(question_id: @question.id)
    answers.delete_all

    redirect_to questions_path
  end

  private
    def question_params
      params.require(:question).permit(:title, :description)
    end
end
