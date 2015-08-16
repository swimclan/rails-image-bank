class SessionsController < ApplicationController
  def login
    # Render the login form
  end

  def create
    # make the login work
    user = User.find_by :email => params[:user][:email]
    puts '-------INBOUND USER----------'
    puts user
    puts '-----------------------------'
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
      @message = "Sorry your email address and/or password do not match"
      session[:user_id] = nil
      render 'sessions/login'
    end
  end

  def logout
    # kill the user session
    session[:user_id] = nil
    redirect_to '/users/login'
  end

end
