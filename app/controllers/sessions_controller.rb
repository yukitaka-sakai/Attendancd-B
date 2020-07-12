class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      # user を引数にすることでデフォルトのURLを設定している。
      redirect_back_or user
      # ログイン後にユーザー情報ページにリダイレクトします。
    else
      # .nowをつけることで１画面だけflashが表示される。
      flash.now[:danger] = "認証に失敗しました。"
      # newアクションへ飛ぶ。つまり、ログインページに戻る。
      render :new
    end
  end
  
  def destroy
    # ログイン中の場合のみログアウト処理できる。
    log_out if logged_in?
    flash[:success] = "ログアウトしました。"
    redirect_to root_url
  end
end
