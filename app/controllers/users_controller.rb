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

    def account
        if current_user
            render "sessions/account"
        else
            render "sessions/new"
        end
    end

    private
        def user_params
            params.require(:user).permit(
                :username, :email, :password, :password_confirmation, :company)
        end
end
