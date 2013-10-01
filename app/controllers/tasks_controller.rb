class TasksController < ApplicationController
  def index
    if params[:user_id]
      @incomplete_tasks = Task.uncomplete.by(params[:user_id])
      @complete_tasks   = Task.complete.by(params[:user_id])
    else
      @incomplete_tasks = Task.uncomplete
      @complete_tasks   = Task.complete
    end
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
