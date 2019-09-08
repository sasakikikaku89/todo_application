    class UsersController < ApplicationController
        before_action :authenticate_user,{only:[:index,:show,:edit,:update]}
        before_action :forbid_login_user,{only:[:new,:login_form,:login,:create]}
        before_action :ensure_correct_user,{only:[:edit,:update]}

        def index
            @users = User.all
        end

        def show
            @user = User.find_by(id: params[:id])
            # @user = User.find_by(id: @task.user_id)
        end

        def my_tasks
            @user = User.find_by(id: params[:id])
            @my_tasks = Task.where(doer: @user.id)            
        end

        def new
            @user = User.new
        end

        def create
            @user = User.new(user_params)
            if @user.save
                session[:user_id] = @user.id
                flash[:notice] = "ユーザー登録が完了しました"
                redirect_to("/users/#{@user.id}")
            else
                render("users/new")
            end
        end

        def edit
            @user = User.find_by(id: params[:id]) 
        end

        def update
            @user =  User.find_by(id: params[:id]) 

            if @user.update(user_params)
                flash[:notice] = "ユーザー情報を編集しました"
                redirect_to("/users/#{@user.id}")
            else
                render("users/edit")
            end
        end

        def login_form
        end

        def login
            @user = User.find_by(email: params[:email])

            if @user && @user.authenticate(params[:password])
                session[:user_id] = @user.id
                flash[:notice] = "ログインしました"
                redirect_to("/tasks/index")
            else
                @error_message = "メールアドレスまたはパスワードが間違っています"
                @email = params[:email]            
                @password = params[:password]
                render("users/login_form")
            end
        end

        def logout
            session[:user_id] = nil
            flash[:notice] = "ログアウトしました"
            redirect_to("/login")
        end

        def ensure_correct_user
            if params[:id].to_i != @current_user.id
              flash[:notice]="権限がありません"
              redirect_to("/tasks/index")
            end
        end

        private
        def user_params
            params.require(:user).permit(:name,:email,:password)
            
        end
    end
