class Task::FollowsController < ApplicationController

  def create
    if current_user
      @task = Task.find(params[:id])
      @task.followers << current_user unless @task.followers.include?(current_user)
    end
    redirect_to :back
  end

  def destroy
    if current_user
      @task = Task.find(params[:id])
      @task.followers.delete(current_user)
    end
    redirect_to :back
  end

end
