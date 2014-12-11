class ResponsesController < ApplicationController

    #show dates for given task
    def new
        @dates = Selectdate.where(task_id: params[:id])
    end

    #create a response for a given user and task
    def create
        @dates = Selectdate.where(id: params[:date_checkbox])
        Response.transaction do
          @dates.each do |date|
            Response.create(selectdate_id: date.id, user_id: current_user.id)
          end
        end

        attendee = Attendee.where(user_id: current_user.id, task_id: @dates.first.task_id).first
        attendee.update_attribute(:answered, true)
        redirect_to account_path
    end
end
