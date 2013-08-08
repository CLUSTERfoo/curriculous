class MemosController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def new
    @memo = Memo.new
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
    if request.xhr?
      render partial: "shared/memo", locals: { memo: @memo } 
    end
  end

  private

    def memo_params
      params.require(:memo).permit(:subject, :content)
    end
end
