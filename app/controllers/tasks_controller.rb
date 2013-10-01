class TasksController < ApplicationController

  before_filter :get_scope_user

  def index
    if @user or current_user
      user = @user || current_user
      @incomplete_tasks = Task.uncomplete.by(user.id)
      @complete_tasks   = Task.complete.by(user.id)
      @following_tasks  = user.following
    else
      all
    end
  end

  def all
    @incomplete_tasks = Task.uncomplete
    @complete_tasks   = Task.complete
    @following_tasks  = []
    render 'index'
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(params[:task])
    redirect_to tasks_url
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes(params[:task])
    redirect_to tasks_url
  end

  def destroy
    @task = Task.destroy(params[:id])
    redirect_to tasks_url
  end

private

  def get_scope_user
    @user = User.find(params[:user_id]) if params[:user_id]
  end

end
