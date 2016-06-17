class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def user_not_signed_in_notice(perform_action, url)
    if !current_user
      flash[:notice] = "You must be signed in to #{perform_action}."
      redirect_to url
    end
  end
  helper_method :user_not_signed_in_notice

  def not_your_question_notice(perform_action, url)
    if current_user.id != @question.user_id
      flash[:notice] = "You can only #{perform_action} for questions you've created."
      redirect_to url
    end
  end
  helper_method :not_your_question_notice
end
