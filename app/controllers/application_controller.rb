class ApplicationController < ActionController::Base
  before_action :basic_auth if Rails.env.production?

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |name, password|
      name == ENV["BASIC_AUTH_NAME"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end
