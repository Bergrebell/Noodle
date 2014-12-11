class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            flash[:notice] = "You signed up successfully"
            session[:user_id] = @user.id
            render "welcome/index"
        else
            flash[:notice] = "Form is invalid"
            render "new"
        end
    end

    def show
        @user = User.find(params[:id])
        render "profile"
    end

    def index
        @searchresults = User.search(params[:search]).to_a
        @searchresults.delete_if {|result| result.id == current_user.id }
        if @searchresults.empty?
            @searchresults = nil
            flash[:notice] = "Couldn't find a user with the name " + params[:search]
        end
        render "friendships/addFriends"
    end

    def multiple_update
      @users = []
      params[:users].each do |id, attributes|
        if user = Attendee.where(task_id: params[:id], user_id: id)
          if user.first.update_attributes(attributes)
            @users << user
          end
        end
      end
      redirect_to :controller => 'tasks', :action => 'event', :id => params[:id]
    end

    private
        def user_params
            params.require(:user).permit(
                :username, :email, :password, :password_confirmation, :company)
        end
end
