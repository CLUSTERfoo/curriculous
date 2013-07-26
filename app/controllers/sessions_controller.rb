class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:session][:username], params[:session][:password])
      redirect_back_or_to(:root, success: "Welcome back")
    else
      flash[:alert] = "Login failed."
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to(:root, notice: "You've logged out. Come back soon!")
  end
end
