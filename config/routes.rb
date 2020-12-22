Rails.application.routes.draw do
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
  #
  get 'users/show' => 'users#show'


  #LP
  get '/' => 'home#top'
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
