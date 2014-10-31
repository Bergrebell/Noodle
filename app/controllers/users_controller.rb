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
        p @searchresults
        if @searchresults.empty?
            @searchresults = User.where.not(:id => current_user.id)
        end
        render "friendships/addFriends"
    end

    private
        def user_params
            params.require(:user).permit(
                :username, :email, :password, :password_confirmation, :company)
        end
end
