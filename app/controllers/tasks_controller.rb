class TasksController < ApplicationController
        before_action :authenticate_user

    def index
        # @tasks = Task.all.order(created_at: :desc)  
        @q = Task.ransack(params[:q])
        @tasks = @q.result(distinct: true)
    end

    def search 
        @q = Task.ransack(params[:q])
        @users = User.all
        @tasks = Task.all
        @search_tasks = @q.result(distinct: true)
    end


    def show
        @task = Task.find_by(id: params[:id])
        @user = User.find_by(id: @task.user_id)

    end

    def new
        @task = Task.new
        @user = User.all
    end

    def create
        @task = Task.new(task_params)

            # user_id: @current_user.id,
            # content: params[:content],
            # doer: params[:doer],
            # deadline: params[:deadline],
            # image_name: "default_task.jpg"            

        # if params[:image]
        #     @task.image_name = "#{@task.id}.jpg"
        #     image = params[:image]
        #     File.binwrite("public/task_images/#{@task.image_name}",image.read)
        # else
        #     @task.image_name = "default_task.jpg"
        # end        
    
        if @task.save
            flash[:notice] = "タスクを登録しました"
            if params[:doer]
                @task.doer = params[:doer].to_i
                @task.save
            end
            if params[:image]
                @task.image_name = "#{@task.id}.jpg"
                @task.save 
                image = params[:image]
                File.binwrite("public/task_images/#{@task.image_name}",image.read)
            end  
            redirect_to("/tasks/index")
        else
            render("tasks/new")
        end
    end

    def edit
        @task = Task.find_by(id: params[:id])
        @user = User.all
    end

    
    def update
        @task = Task.find_by(id: params[:id])    
        # @task.user_id = @current_user.id
        # @task.content = params[:content]
        # @task.doer = params[:doer]
        # @task.deadline = params[:deadline]
        
        # if params[:image]
        #     @task.image_name = "#{@task.id}.jpg"
        #     image = params[:image]
        #     File.binwrite("public/task_images/#{@task.image_name}", image.read)
        # end    
        if @task.update(task_params)
            flash[:notice] = "ユーザー情報を編集しました"
            if params[:doer]
                @task.doer = params[:doer].to_i
                @task.save
            end
            if params[:image]
                @task.image_name = "#{@task.id}.jpg"
                @task.save 
                image = params[:image]
                File.binwrite("public/task_images/#{@task.image_name}",image.read)
            end  
            redirect_to("/tasks/#{@task.id}")
        else
            render("tasks/edit")
        end
    end

    def destroy
        @task = Task.find_by(id: params[:id])
        if @task.destroy
            flash[:notice] = "投稿を削除しました"
            redirect_to("/tasks/index")
        end
    end

    private
    def task_params
        params.require(:task).permit(:content,:doer,:deadline).merge(user_id: @current_user.id,image_name: "default_task.jpg")
    end




end
