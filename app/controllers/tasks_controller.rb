class TasksController < ApplicationController

  def new
    @task = Task.new
  end

  def create
    #render text: params[:task].inspect
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
  end

  def select_user
    @testuser = Testuser.all
    @task = Task.find(params[:id])
  end

#filling out the user select checkboxes
  def participate

#participation_ids = params[:user_checkbox]

    @task = Task.find(params[:id])
    @task.testusers << Testuser.all
    #@task.save

# in case if you need to run validations and callbacks on each Attendee
# you pull all records by 1 query and then update each

    @attendees = Attendee.where(testuser_id: params[:user_checkbox])
    Attendee.transaction do
      @attendees.each do |attendee|
        attendee.update_attributes!(participate: true)
      end
    end

    @participant = Attendee.where(participate: true, task_id: params[:id])
    #use pluck to query for a single field from a db!
    @participant_array = @participant.pluck(:testuser_id)
    @participant_array.uniq
    end



  def user_weight

  end

  private
    def task_params
      params.require(:task).permit(:title, :text)
    end

end


