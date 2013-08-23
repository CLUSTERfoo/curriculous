class MemosController < ApplicationController
  before_action :require_login, only: [:new, :create, :destroy]

  def new
    @memo = Memo.new
    respond_to do |format|
      format.html
      format.js {}
    end
  end

  def create
    @memo = current_user.memos.build(memo_params)
    if @memo.save
      respond_to do |format|
        format.html do 
          flash[:success] = "Your memo has been posted!"
          redirect_to memo_path(@memo.token)
        end
        format.js
      end
    else
      render 'new'
    end
  end

  def destroy
    Memo.find_by_token(params[:id]).destroy
    flash[:success] = "Memo @#{ params[:token] } has been destroyed!"
    redirect_to root_path
  end

  def index
  end

  def show
    @memo = Memo.find_by_token(params[:token])
    @reply = Memo.new
    respond_to do |format|
      format.html
      format.js {}
    end
  end

  def replies
    @parent_memo = Memo.find_by_token(params[:token])
    respond_to do |format|
      format.html
      format.js {}
    end
  end

  private

    def memo_params
      params.require(:memo).permit(:subject, :content, :nsfw)
    end
end
