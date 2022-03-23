class UsersController < ApplicationController
  def show
    :authenticate_user
    render json: current_user()
  end

  def create
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      admin: params[:admin] || false,
    )

    if user.save
      render json: { message: "User created successfully" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def update
    user = User.find_by(id: params[:id])
    user.name = params[:name] || user.name
    user.email = params[:email] || user.email
    # Can the user password be updated using this method?
    # user.password = params[:password] || user.password
    # user.password_confirmation = params[:password_confirmation] || user.password_confirmation
    user.admin = params[:admin] || user.admin

    if user.save
      render json: user.as_json
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end
end
