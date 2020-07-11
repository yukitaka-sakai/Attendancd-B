class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      redirect_to user
       # ログイン後にユーザー情報ページにリダイレクトします。
    else
      flash.now[:danger] = "認証に失敗しました。"
      render :new
    end
  end
  
  def destroy
    #ログイン中の場合のみログアウト処理できる。
    log_out　if logged_in?
    flash[:success] = "ログアウトしました。"
    redirect_to root_url
  end
end
