class UsersController < ApplicationController
  def register
    # render the registration view
  end

  def create
    # process the new registration
    @user = User.new(user_params)
    if @user.save
      # the user is successfully registered and logged in
      session[:user_id] = @user.id
      redirect_to '/'
    else
      # something is wrong with the registration generate a flash message to the user
      @message = "Sorry, the user already exists or the passwords did not match"
      session[:user_is] = nil
      render 'users/register'
    end

  end

  # private methods that are not exposed to external scopes
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


end
