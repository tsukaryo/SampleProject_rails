class UsersController < ApplicationController
  #ユーザー作るページを表示する時
  def new
  end

  #ユーザー作成のアクション
  def create
    #ユーザーのインスタンス作成
    @user=User.new(name: params[:name], email: params[:email], password: params[:password])
    #データベースに保存できたこととパスワードの確認ができたことを確認
    if (params[:password]==params[:password_config]) && @user.save

      flash[:success]="登録完了"
      #メール送信のメソッドをおく
      render("users/configration_page")
    else

      flash.now[:error]="エラー"
      @name=params[:name]
      @email=params[:email]
      
      render("users/new")
    end

  end
  
  def login
    @user=User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id]=@user.id
      flash[:success]="ログイン完了"
      redirect_to("/users/show")
    else
      #renderの前には.nowが必要
      flash.now[:error]="fail"
      @email=params[:email]
      @password=params[:password]
      render("users/login_page")
    end
  end

  #ログインページの表示
  def login_page
  end


  def show
  end
  
end
