class ResponsesController < ApplicationController
    def new
        @dates = Selectdate.where(task_id: params[:id])
        p @dates
    end

    def create
        @dates = Selectdate.where(id: params[:date_checkbox])
        Response.transaction do
          @dates.each do |date|
            Response.create(selectdate_id: date.id, user_id: current_user.id)
          end
        end

        redirect_to responses_path
    end

    def show
    end
end
