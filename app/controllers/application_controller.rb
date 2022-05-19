# frozen_string_literal: true

class ApplicationController < ActionController::API
  attr_reader :current_user

  def not_found
    render json: { error: 'not_found' }, status: not_found
  end

  def authorize
    result = Session::Operation::Authorization.call(token: request.headers['Authorization'])
    if result.success?
      @current_user = result[:current_user]
    else
      render json: { errors: result[:errors].message }, status: :unauthorized
    end
  end

  private

  def _run_options(options)
    options.merge(current_user:)
  end
end
