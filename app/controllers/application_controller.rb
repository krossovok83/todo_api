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
    auth_required? ? options.merge(current_user:) : options
  end

  def auth_required?
    true unless (params[:controller] == 'api/v1/login' && params[:action] == 'create') ||
      params[:controller] == 'api/v1/users'
  end
end
