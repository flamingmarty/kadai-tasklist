class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
      #@tasks = Task.all
      
      if logged_in?
        #@task = current_user.tasks.build  # form_with 用
        @tasks = current_user.tasks.order(id: :asc).page(params[:page]).per(5)
      end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    #@task = Task.new(task_params)
    
    @task = current_user.tasks.build(task_params)

    if @task.save
      flash[:success] = 'Task が正常に作成されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が作成されませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'Task が正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy

    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url      
  end
  
  private
  
  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url  #タスク一覧ページを指定
    end
  end
  
end