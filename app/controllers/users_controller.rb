class UsersController < ApplicationController
  # before_actionを使って何らかの処理(indexとeditとupdateとdestroy)が実行される直前に
  # 特定のメソッドを実行する
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  # destroyアクションを行えるのは管理者権限を持つユーザーのみ
  before_action :admin_user,     only: :destroy
  
  def index
    # データベース上の全ユーザーを取得
    # ビューで使えるインスタンス変数@usersに代入
    # @user = User.all
    @users = User.paginate(page: params[:page])
  end

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
      # log_in @user
      # 初回のみ登録完了のメッセージを表示
      # flash[:success] = "Welcome to the Sample App!"
      # 保存に成功したら対応するviewに飛ばす
      # 下のコードはredirect_to user_url(@user)と同じ
      # redirect_to @user

      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  # ユーザー編集
  def edit
    @user = User.find(params[:id])
  end

  # 送信されたparamsハッシュに基いてユーザーを更新
  def Update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # 該当するユーザーを見つけてActive Recordのdestroyメソッドを使って削除
  # 最後にユーザーindexに移動
  # 削除できるのはadmin属性がtrueの管理者権限を持つユーザーのみ
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  # privateメソッドは外部から使えない
  private

    def user_params
      # User.new(params[:user])だとユーザーが送信したデータをまるごとUser.newに渡すことになるので危険
      # permitに:adminを入れると任意のユーザーが自分自身にアプリケーションの管理者権限を与える危険性がある
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        # store_locationはsessions_helperから
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      # current_user?はsessions_helperから
      redirect_to(root_url) unless current_user?(@user)
    end
end
