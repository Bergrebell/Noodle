class SessionsController < ApplicationController
    def new
    end

    def create
      user = User.authenticate(params[:email], params[:password])
      if user
        session[:user_id] = user.id
        redirect_to root_url, :notice => "Logged in"
      else
        flash.now.alert = "Invalid email or password"
        render "new"
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to root_url, :notice => "Logged out"
    end

    def account
        if current_user
            @events = Task.where(user_id: current_user.id)
            @taskids = Attendee.where(user_id: current_user.id, participate: true).pluck(:task_id)
            einvites = Array.new
            @taskids.each do |id|
              einvites.append(Task.where(id: id).flatten)
            end
            p einvites
            @einvites = einvites
            render "account"
        else
            render "sessions/new"
        end
    end
end
