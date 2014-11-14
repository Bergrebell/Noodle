class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            flash[:notice] = "You signed up successfully"
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
        @searchresults = User.search(params[:search])
        if @searchresults.empty?
            @searchresults = nil
            flash[:notice] = "Couldn't find a user with the name " + params[:search]
        end
        render "friendships/addFriends"
    end

    private
        def user_params
            params.require(:user).permit(
                :username, :email, :password, :password_confirmation, :company)
        end
end
