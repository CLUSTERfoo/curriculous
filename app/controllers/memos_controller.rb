class MemosController < ApplicationController
  before_action :require_login, only: [:new, :create]

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
      flash[:success] = "Your memo has been posted!"
      redirect_to memo_path(@memo.token)
    else
      render 'new'
    end
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

  private

    def memo_params
      params.require(:memo).permit(:subject, :content)
    end
end
