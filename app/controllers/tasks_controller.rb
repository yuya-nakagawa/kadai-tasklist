class TasksController < ApplicationController
    before_action :correct_user, only: [:show, :edit, :update, :destroy]
    before_action :require_user_logged_in
    def index
        @tasks = current_user.tasks.order(id: :desc).page(params[:page]).per(10)
    end
    
    def show
    end
    
    def new
        @task = current_user.tasks.build
    end
    
    def create
        @task = current_user.tasks.build(task_params)
        
        if @task.save
            flash[:success] = 'タスクを追加しました'
            redirect_to @task
        else
            flash.now[:danger] = 'タスクを追加できませんでした'
            render :new
        end
    end
    
    def edit
    end
    
    def update

        if @task.update(task_params)
            flash[:success] = 'タスクは更新されました'
            redirect_to @task
        else
            flash.now[:danger] = 'タスクは更新されませんでした'
            render :edit
        end
    end
    
    def destroy
        @task.destroy
        
        flash[:success] = 'タスクは削除されました'
        redirect_back(fallback_location: root_path)
    end
    
    private
    
    # 共通化
    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
          redirect_to root_url
        end
    end
    
    # Strong Parameter
    def task_params
        params.require(:task).permit(:content, :status)
    end
end
