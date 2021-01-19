class Api::V1::UsersController < ApplicationController
  def create
    if params[:email].empty? || params[:password].empty? || params[:password_confirmation].empty?
      render json: { 'error': 'Missing required information: Fields cannot be blank' }, status: :bad_request
    elsif User.exists?(email: params[:email])
      render json: { 'error': 'Account with this email already exists' }, status: :bad_request
    elsif params[:password] != params[:password_confirmation]
      render json: { 'error': 'Passwords do not match' }, status: :bad_request
    elsif params[:password] == params[:password_confirmation]
      render json: UserSerializer.new(User.create(user_params)), status: :created
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
