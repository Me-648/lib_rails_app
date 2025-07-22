class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(student_no: params[:student_no])
    if user && user.password == params[:password]
      session[:user_id] = user.id
      redirect_to books_path, notice: "ログインしました"
    else
      flash[:alert] = "学生番号またはパスワードが間違っています"
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to books_path, notice: "ログアウトしました"
  end
end
