class StaticPagesController < ApplicationController
  def home
    @memos = Memo.paginate(page: params[:page])
  end

  def contribute
  end

  def about
  end
end
