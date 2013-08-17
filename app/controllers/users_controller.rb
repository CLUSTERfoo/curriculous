class UsersController < ApplicationController
  before_action :require_login, only: [:inbox]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if params[:phone].present?
      render 'new'
    elsif @user.save
      flash[:success] = "Your account has been created. Welcome, 
                        #{ @user.username }!"
      auto_login(@user)
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @memos = @user.memos.paginate(page: params[:page])
  end

  def inbox
    @user = current_user
    @replies = @user.replies.paginate(page: params[:page])
  end

  private

    def user_params
      params.require(:user).permit( :username, :email,
                                    :password, :password_confirmation)
    end
end
