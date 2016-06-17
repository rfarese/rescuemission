require 'capybara/rspec'
require_relative 'support/authentication_helper'
require_relative 'support/database_cleaner'
require_relative 'support/user_creator_helper'
require_relative 'support/question_creator_helper'
require_relative 'support/answer_creator_helper'
require 'omniauth'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before :each do
    OmniAuth.config.mock_auth[:twitter] = nil
  end

  OmniAuth.config.test_mode = true
  config.include AuthenticationHelper
  config.include UserCreatorHelper
  config.include QuestionCreatorHelper
  config.include AnswerCreatorHelper
end
