class UsersController < ApplicationController
  before_action :get_user, only: %i[show]

  rescue_from NoMethodError, with: :no_user

  def new
  end

  def show
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/dashboard'
    else
      user.errors.full_messages.each do |message|
        flash[:notice] = message
      end
      render :new
    end
  end
  def login_form; end
  def login_auth
    user = User.find_by(email: params[:email])

    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/dashboard'
    else
      flash[:notice] = 'invalid entry'
      render :login_form
    end
  end

  private

  def get_user
    @user = User.find(session[:user_id])
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def no_user
    flash[:notice] = 'invalid entry'
    render :login_form
  end
end
