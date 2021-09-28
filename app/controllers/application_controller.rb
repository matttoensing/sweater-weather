class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  # include ActionController::HttpAuthentication::Basic::ControllerMethods
  # include ActionController::HttpAuthentication::Token::ControllerMethods
end
