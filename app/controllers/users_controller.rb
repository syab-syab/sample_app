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
end
