class ApplicationController < ActionController::Base
  prepend_before_filter :protect_application!

  protected
  def protect_application!
    return true unless ENV['PROTECTION_PASSWORD']
    authenticate_or_request_with_http_basic do |username, password|
      password == ENV['PROTECTION_PASSWORD']
    end
  end
end
