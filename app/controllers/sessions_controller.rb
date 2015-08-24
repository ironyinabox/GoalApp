class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_cred(username_input, password_input)
    if @user
      log_in(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = ["No matches for that password and username"]
      render :new
    end
  end

  def destroy
    log_out
    redirect_to new_session_url
  end

  private
  def username_input
    params[:user][:username]
  end

  def password_input
    params[:user][:password]
  end
end
