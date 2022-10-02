class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # authenticateはhas_secure_passwordが提供する
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      # log_inはsessions_helperから
      log_in user
      # チェックボックスがオンのときに'1'になり、オフのときに'0'
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      # rememberはuser.rbから
      # remember user
      redirect_back_or user
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    # log_out・logged_inともにsessions_helperから
    log_out if logged_in?
    redirect_to root_url
  end
end
