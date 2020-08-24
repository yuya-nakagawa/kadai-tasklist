class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    before_action :require_user_logged_in
    def index
        @tasks = Task.order(id: :desc).page(params[:page]).per(10)
    end
    
    def show
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = Task.new(task_params)
        
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
        redirect_to tasks_url
    end
    
    private
    
    # 共通化
    def set_task
        @task = Task.find(params[:id])
    end
    
    # Strong Parameter
    def task_params
        params.require(:task).permit(:content, :status)
    end
end
