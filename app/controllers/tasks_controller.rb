class TasksController < ApplicationController

  def new
    @task = Task.new
  end

  def create
    #render text: params[:task].inspect

    @task = Task.new(task_params)

    if @task.save
      redirect_to @task
    else
      render 'new'
    end

  end

  def show
    @task = Task.find(params[:id])
  end


  private
    def task_params
      params.require(:task).permit(:title, :text)
    end
end
