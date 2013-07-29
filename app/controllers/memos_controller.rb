class MemosController < ApplicationController
  before_action :require_login, only: [:create]

  def new
    @memo = Memo.new
  end

  def create
    @memo = current_user.memos.build(memo_params)
    if @memo.save
      flash[:success] = "Your memo has been posted!"
      redirect_to memo_path(@memo)
    else
      render 'new'
    end
  end

  def index
  end

  def show
    @memo = Memo.find(params[:id])
  end

  private

    def memo_params
      params.require(:memo).permit(:subject, :content)
    end
end
