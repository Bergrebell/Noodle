class SessionsController < ApplicationController

    #login user
    def create
      user = User.authenticate(params[:email], params[:password])
      if user
        session[:user_id] = user.id
        redirect_to root_url, :notice => "Logged in"
      else
        flash[:notice] = "Invalid email or password"
        render "new"
      end
    end

    #destroy user session e.g. logout
    def destroy
      session[:user_id] = nil
      redirect_to root_url, :notice => "Logged out"
    end

    #show user account
    def account
        if current_user
            @events = Task.where(user_id: current_user.id)
            @taskids = Attendee.where(user_id: current_user.id, participate: true, answered: nil).pluck(:task_id)
            @attend = Attendee.where(user_id: current_user.id, answered: true)
            einvites = Array.new
            @taskids.each do |id|
              einvites.append(Task.where(id: id).flatten)
            end
            @einvites = einvites
            render "account"
        else
            render "sessions/new"
        end
    end
end
