class MicropostsController < ApplicationController
  # logged_in_userはapplication_controller.rbにある
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    # 新しいmicropostを作るためにcurrent_user(session_helperから)でuserと関連付け
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private

    def micropost_params
      # マイクロポストのcontent属性だけがWeb経由で変更可能
      params.require(:micropost).permit(:content)
    end
end