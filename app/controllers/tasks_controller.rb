class TasksController < ApplicationController

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      #flash[:success] = "Great! Your task has been created!"
      redirect_to :action => 'select_date', :id => @task
    else
      render 'new'
    end
  end

  def show
    @task = Task.find(params[:id])
  end


  def select_date
    @task = Task.find(params[:id])
    @taskdates = Selectdate.where(task_id: params[:id])
  end

  def create_date
    @task = Task.find(params[:id])
    #@task.update_attributes!(meeting_date: params[:tasks][:meeting_date], meeting_start_time: params[:tasks][:started_at], meeting_end_time: params[:tasks][:ended_at])
    @taskdates = @task.selectdates.create(task_date: params[:tasks][:meeting_date])

    redirect_to :action => 'select_date', :id => @task

  end

  def select_user
    @user = User.all
    @task = Task.find(params[:id])
  end

  def participate
    @task = Task.find(params[:id])
    @task.users << User.all

    @attendees = Attendee.where(User_id: params[:user_checkbox])
    Attendee.transaction do
      @attendees.each do |attendee|
        attendee.update_attributes!(participate: true)
      end
    end

    redirect_to :action => 'user_weight', :id => @task
  end


  def user_weight
    @participant = Attendee.where(participate: true, task_id: params[:id])
    #use pluck to query for a single field from a db!
    @participant_array = @participant.pluck(:user_id)
    @participant_array.uniq
  end


  def create_user_weight
    @participant = Attendee.where(participate: true, task_id: params[:id])
    #use pluck to query for a single field from a db!
    @participant_array = @participant.pluck(:user_id)
    @participant_array.uniq




  end

  private
    def task_params
      params.require(:task).permit(:title, :text)
    end

end


