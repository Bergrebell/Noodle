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

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = "Removed task"
    redirect_to account_path
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
    #@taskdates = @task.selectdates.create(task_date: params[:tasks][:meeting_date])
    @taskdates = @task.selectdates.create()
    date = params[:tasks][:meeting_date] + " "
    time = params[:tasks][:meeting_time]
    datetime = date << time
    @taskdates.update_attributes!(task_date: datetime)

    redirect_to :action => 'select_date', :id => @task

  end

  def delete_date
    @task = Task.find(params[:id])
    @date = Selectdate.where(task_id: params[:id])
    @date.destroy
    flash[:notice] = "Date removed"
    redirect_to :action => 'select_date', :id => @task
  end

  def select_user
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
    @participants = Attendee.where(participate: true, task_id: params[:id])
    @task = Task.find(params[:id])
    #@users = @participants.map { |p| User.find_by id: p.user_id }.to_set.to_a
  end


  def create_user_weight
    @participant = Attendee.where(participate: true, task_id: params[:id])
  end


  def event
    @task = Task.where(id: params[:id])
    @dates = Selectdate.where(task_id: params[:id])
    @comments = Comment.where(task_id: params[:id])
    @participants = Attendee.where(participate: true, task_id: params[:id])
    @users = @participants.map { |p| User.find_by id: p.user_id }.to_set.to_a
    score = Hash.new
    @dates.each do |date|
      score.merge!("#{date.id}" => 0)
    end
    @dates.each do |date|
      responses = Response.where(selectdate_id: date.id)
      responses.each do |response|
        weight = Attendee.where(user_id: response.user_id, task_id: params[:id]).first.user_weight
        score["#{date.id}"] += weight**2
      end
    end
    score.sort_by { |k, v| v }.reverse
    p @suggestion = score.first
  end


  private
    def task_params
      params.require(:task).permit(:title, :text, :user_id)
    end

end


