class StaticPagesController < ApplicationController
  def home
    # @micropost変数がログインしているときのみ定義できるようにするため
    # ユーザーがログインしているときしか使えないcurrent_user(session_helper)を使う
    @micropost = current_user.microposts.build if logged_in?
    @feed_items = current_user.feed.paginate(page: params[:page])
  end

  def help
  end

  def about
  end

  def contact
  end
end
