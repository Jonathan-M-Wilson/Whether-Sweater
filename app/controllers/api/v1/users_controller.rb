class Api::V1::UsersController < ApplicationController
  def create
    if params[:email].empty? || params[:password].empty? || params[:password_confirmation].empty?
      render json: { 'error': 'Missing required information: Fields cannot be blank' }, status: 400
    elsif User.exists?(email: params[:email])
      render json: { 'error': 'Account with this email already exists' }, status: 400
    elsif params[:password] != params[:password_confirmation]
      render json: { 'error': 'Passwords do not match' }, status: 400
    elsif params[:password] == params[:password_confirmation]
      render json: UserSerializer.new(User.create(user_params)), status: 201
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
