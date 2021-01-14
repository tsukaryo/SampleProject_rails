Rails.application.routes.draw do


  #LP
  get '/' => 'home#top'
  #新規登録ページの表示
  get 'users/new' => 'users#new'
  #新規登録のアクション
  post 'users/create' => 'users#create'
  #メール認証のメールに記載するURL
  get 'users/:id/configration' => 'users#configration'
  #ログインページの表示
  get 'users/login_page' => 'users#login_page'
  #ログインのアクション
  post 'users/login' => 'users#login'
  #マイページ表示
  get 'users/:id/show' => 'users#show'
  #メール認証用URL
  get 'users/:id/authenticate' => 'users#authenticate'
  #ユーザー情報更新
  get 'users/:id/edit' => 'users#edit'
  #ログアウト
  post 'users/:id/logout' => 'users#logout'

  #ユーザの投稿一覧ページ(idはユーザー)
  get 'posts/:id/index' => 'posts#index'
  #投稿の作成ページ(idはユーザー)
  get 'posts/:id/new' => 'posts#new'
  #投稿の作成
  post 'posts/create' => 'posts#create'
  #投稿の編集ページ(idは投稿)
  get 'posts/:id/edit' => 'posts#edit'
  #投稿の更新(idは投稿)
  post 'posts/:id/update' => 'posts#update'
  #投稿の削除(idは投稿)
  post 'posts/:id/delete' => 'posts#delete'

  #フォロー一覧
  get 'users/:id/follow_index' => 'users#follow_index'
  #フォローやめる
  post 'users/:id/quit' => 'users#quit'
  #フォローしている人の詳細ページ
  get 'users/:id/detail' => 'users#detail'
  #フォロー
  post 'users/:id/follow' => 'users#follow'
  #ユーザーの一覧ページ
  get 'users/index' => 'users#index'
  #ホーム(idはユーザー)
  get 'users/:id/home' => 'users#home'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
