class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def index
        @users = User.all
    end

    def create
        @user = User.new(user_params)

        if @user.save
            flash[:notice] = "You signed up successfully"
            flash[:color]= "valid"
            render "welcome/index"
        else
            flash[:notice] = "Form is invalid"
            flash[:color]= "invalid"
            render "new"
        end
    end

    def show
        @user = User.find(params[:id])
    end 

    private
        def user_params
            params.require(:user).permit(
                :username, :email, :password, :password_confirmation)
        end  

    before_filter :save_login_state, :only => [:new, :create] 
end
