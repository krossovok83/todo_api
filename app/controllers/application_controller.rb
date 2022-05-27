# frozen_string_literal: true

class ApplicationController < ActionController::API
  attr_reader :current_user
  include JWTSessions::RailsAuthorization
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

  def not_authorized
    head :unauthorized
  end

  def not_found
    head :not_found
  end

  def current_user
    @current_user ||= User.find(payload["user_id"])
  end

  private

  def _run_options(options)
    return {} if (params[:controller] == 'api/v1/login' && params[:action] == 'create') ||
      (params[:controller] == 'api/v1/users' && params[:action] == 'create')
    options.merge(current_user:)
  end
end
