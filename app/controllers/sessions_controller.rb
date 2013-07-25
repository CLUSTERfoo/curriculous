class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:session][:username], params[:session][:password])
      redirect_back_or_to(:root, success: "Welcome back")
    else
      render 'new'
    end
  end

  def destroy
  end
end
