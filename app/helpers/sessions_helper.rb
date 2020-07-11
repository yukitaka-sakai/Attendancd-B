module SessionsHelper
  
  #引数に渡されたユーザーオブジェクトでログインする。
  def log_in(user)
    session[:user_id] = user.id
  end
  
  
  #現在ログイン中のユーザーがいる場合、オブジェクトを返す。
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  
  def logged_in?
    !current_user.nil?
  end
end
