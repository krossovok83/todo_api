# frozen_string_literal: true

class ApplicationController < ActionController::API
  def not_found
    render json: { error: 'not_found' }
  end

  def authorize
    result = Session::Operation::Authorization.call(token: request.headers['Authorization'])
    if result.success?
      @current_user = result[:user]
    else
      render json: { errors: result[:errors].message }, status: :unauthorized
    end
  end
end
