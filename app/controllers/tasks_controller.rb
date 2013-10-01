class TasksController < ApplicationController

  def index
    if params[:user_id] or current_user
      user_id = params[:user_id] || current_user.id
      @incomplete_tasks = Task.uncomplete.by(user_id)
      @complete_tasks   = Task.complete.by(user_id)
    else
      all
    end
  end

  def all
    @incomplete_tasks = Task.uncomplete
    @complete_tasks   = Task.complete
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
end
