class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index #記載不要
  end

  def show #記載不要
  end

  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      
      #session[:user_id] = @user.id  #signup後にタスク一覧ページを表示させたい場合は必要
      redirect_to root_url #タスク一覧ページを指定
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
