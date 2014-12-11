class TasksController < ApplicationController

  def new
    @task = Task.new
  end

  #create a new event
  def create
    @task = Task.new(task_params)
    if @task.save
      #flash[:success] = "Great! Your task has been created!"
      redirect_to :action => 'select_date', :id => @task
    else
      render 'new'
    end
  end

  #destroy a given event
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = "Removed event"
    redirect_to account_path
  end

  #show all events
  def show
    @task = Task.find(params[:id])
  end

  #show select dates page
  def select_date
    @task = Task.find(params[:id])
    @taskdates = Selectdate.where(task_id: params[:id])
  end

  #add dates to a given event
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

  #delete dates from a given event
  def delete_date
    @task = Task.find(params[:task_id])
    @date = Selectdate.where(id: params[:date_id]).first
    @date.destroy
    flash[:notice] = "Date removed"
    redirect_to :action => 'select_date', :id => @task
  end

  #show the select participant page
  def select_user
    @task = Task.find(params[:id])
    if @task.selectdates.length < 2
      flash[:notice] = "Please choose at least two dates"
      redirect_to :action => 'select_date', :id => @task
    end
  end

  #add users to the event
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


  #show the select user weight page
  def user_weight
    @task = Task.find(params[:id])
    users = @task.attendees.where(participate: true)
    if users.length < 2
      flash[:notice] = "Please choose at least two participants"
      redirect_to :action => 'select_user', :id => @task
    end
    @participants = Attendee.where(participate: true, task_id: params[:id])
  end

  #add user weights to participants
  def create_user_weight
    @participant = Attendee.where(participate: true, task_id: params[:id])
  end


  #show the event overview page
  def event
    @task = Task.where(id: params[:id])
    @dates = Selectdate.where(task_id: params[:id]).order('task_date')
    @comments = Comment.where(task_id: params[:id])
    @attachments = Attachment.where(task_id: params[:id])
    p @attachments
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
        score["#{date.id}"] += weight
      end
    end
    score = score.sort_by{ |k, v| v }.reverse
    @suggestion = score
  end


  private
    def task_params
      params.require(:task).permit(:title, :text, :user_id)
    end

end


