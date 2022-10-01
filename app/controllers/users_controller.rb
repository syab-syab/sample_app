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
    @user = User.new(user_params)
    # 作成の正否によって処理を分ける
    if @user.save
      # 登録が終わった直後に自動的にログイン
      # log_inメソッドはsessions_helperから
      log_in @user
      # 初回のみ登録完了のメッセージを表示
      flash[:success] = "Welcome to the Sample App!"
      # 保存に成功したら対応するviewに飛ばす
      # 下のコードはredirect_to user_url(@user)と同じ
      redirect_to @user
    else
      render 'new'
    end
  end

  # privateメソッドは外部から使えない
  private

    def user_params
      # User.new(params[:user])だとユーザーが送信したデータをまるごとUser.newに渡すことになるので危険
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
