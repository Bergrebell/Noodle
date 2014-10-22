class TasksController < ApplicationController

  def new
  end

  def create
    #render text: params[:task].inspect

    @task = Task.new(task_params)

    @task.save
    redirect_to @task
  end

  def show
    @task = Task.find(params[:id])
  end


  private
    def task_params
      params.require(:task).permit(:title, :text)
    end
end
