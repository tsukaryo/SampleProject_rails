class PostsController < ApplicationController
    def new
    end

    def create
        @user=User.find(session[:user_id])
        @post=Post.new(user_id: @user.id,  content: params[:content])
        if @post.save
            flash[:success]='投稿しました'
            redirect_to("/users/#{@user.id}/show")
        else
            flash[:error]='投稿に失敗しました'
            render('/posts/new')
        end
    end

    def update
        @user=User.find(session[:user_id])
        @post=Post.find(params[:id])
        @post.update_columns(content: params[:content])
        flash[:success]='投稿を更新しました'
        redirect_to("/users/#{@user.id}/show")
    end

    def delete
        @user=User.find(session[:user_id])
        @post=Post.find_by(id: params[:id])
        @post.destroy
        flash[:success]="投稿を削除しました"
        redirect_to("/users/#{@user.id}/show")
    end

    def edit
        @user=User.find(session[:user_id])
        @post=Post.find(params[:id])
    end

    def index
        @user=User.find(session[:user_id])
        @posts=Post.where(user_id: session[:user_id]).order(created_at: "DESC") 
    end

end
