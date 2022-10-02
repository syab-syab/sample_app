class MicropostsController < ApplicationController
  # logged_in_userはapplication_controller.rbにある
  before_action :logged_in_user, only: [:create, :destroy]
  # destroyアクションの前にcorrect_userを挟む
  before_action :correct_user,   only: :destroy

  # マイクロポスト作成
  def create
    # 新しいmicropostを作るためにcurrent_user(session_helperから)でuserと関連付け
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  # マイクロポスト削除
  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  private

    def micropost_params
      # マイクロポストのcontent属性だけがWeb経由で変更可能
      # 画像投稿のためにpicture属性も
      params.require(:micropost).permit(:content, :picture)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end