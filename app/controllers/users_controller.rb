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
      UserMailer.send_mail(@user).deliver_now
      flash[:success]="登録完了"
      #メール送信のメソッドをおく
      render("users/configration_page")
    else

      flash.now[:danger]="エラー"
      @name=params[:name]
      @email=params[:email]
      
      render("users/new")
    end

  end
  
  def login
    @user=User.find_by(email: params[:email], password: params[:password])
    if @user && @user.mail_auth
      session[:user_id]=@user.id
      flash[:success]="ログイン完了"
      redirect_to("/users/#{@user.id}/show")
    else
      #renderの前には.nowが必要
      flash.now[:danger]="ログイン失敗"
      @email=params[:email]
      @password=params[:password]
      render("users/login_page")
    end
  end

  #ログインページの表示
  def login_page
  end


  def show
    @user=User.find(session[:user_id])

  end
  
  def authenticate
    #メールに記載されているの:idからユーザーを取得
    @user = User.find(params[:id])
    #user.configをnilから１にして認証されていることを確認
    @user.update_columns(mail_auth: true)
    #ついでにログインも済ませるためにセッションも立たせる
    session[:user_id] = @user.id
  end

  def logout
    @user=User.find_by(id: session[:id])
    session[:user_id]=0
    redirect_to('/')
  end

  def follow_index
    @follows=Follow.where(user_id: params[:id])
    follow_user_array=[]

    #フォローしている人の配列を作成
    @follows.each do |fo|
      follow_user_array.push(fo.follow_user_id)
    end
    #配列を元にフォローしている人のユーザー情報を取り出す
    @follow_users=User.where(id: follow_user_array)

  end


  def quit
    @user=User.find(session[:user_id])
    @following=Follow.find_by(user_id: @user.id , follow_user_id: params[:id])
    @following.destroy
    redirect_to("/users/#{@user.id}/follow_index")
  end

  def detail
    @user=User.find(session[:user_id])
    @follow_user=User.find_by(id: params[:id])
    @posts=Post.where(user_id: @follow_user).order(created_at: "DESC")
  end

  def index
    @users=User.all
  end

  def follow
    @user=User.find(session[:user_id])
    @fo=Follow.new(user_id: @user.id, follow_user_id: params[:id])
    if @fo.save
      flash[:success]="フォローしました"
      redirect_to("/users/index")
    else
      flash[:danger]="フォローに失敗"
      render("/users/index")
    end

  end

  def home 
    follow_user_array=[]
    @follows=Follow.where(user_id: params[:id])
    @follows.each do |fo|
      follow_user_array.push(fo.follow_user_id)
    end
    @posts=Post.where(user_id: follow_user_array).order(created_at: "DESC")
    @tweet_user_name_array=[]
    @posts.each do |post|
      user=User.find(post.user_id)
      @tweet_user_name_array.push(user.name)
    end
    
    
    

  end
end
