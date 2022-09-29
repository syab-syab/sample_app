class UsersController < ApplicationController
  # /users/[idの数値]でアクセスできる
  def show
    # paramsはユーザーIDの読み出し
    # params[:id]の部分はidの数値に置き換わる
    @user = User.find(params[:id])
  end

  # ユーザー登録(Signup)
  def new
    @user = User.new
  end

  # /usersへのPOSTリクエストはcreateに送られる(route.rbの[resources :users]によって)
  def create
    # フォーム送信を受け取りUser.newで新規ユーザー作成
    @user = User.new(params[:user])
    # 作成の正否によって処理を分ける
    if @user.save
      # 
    else
      render 'new'
    end
  end
end
