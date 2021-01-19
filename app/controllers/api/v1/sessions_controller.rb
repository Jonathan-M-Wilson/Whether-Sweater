class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user.nil?
      render json: { 'error': 'Given email address does not match our records, try again' }, status: :bad_request
    elsif !user.nil? && user.authenticate(params[:password])
      render json: UserSerializer.new(user)
    else
      render json: { 'error': 'Something went wrong, Please Try Again' }, status: :bad_request
    end
  end
end
