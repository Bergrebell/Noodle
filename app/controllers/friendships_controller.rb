class FriendshipsController < ApplicationController

    def new
        @myfriendships = Friendship.where(:user_id => current_user.id)
        possiblefriends = User.all
        users = Array.new
        possiblefriends.each do |user|
            if not @myfriendships.exists?(:friend_id => user.id)
                users.append(user)
            end
        end
        @users = users
        render "addFriends"
    end

    def create
        @myfriendships = Friendship.where(:user_id => current_user.id)
        if not @myfriendships.exists?(:friend_id => params[:friend_id])
            @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
            if @friendship.save
                flash[:notice] = "Friend added"
                redirect_to addfriends_path
            else
                flash[:notice] = "Unable to add friend"
                render "addFriends"
            end
        else
            flash[:notice] = "You are already friends with this user"
            render "addFriends"
        end    
    end

    def destroy
        @friendship = current_user.friendships.find(params[:id])
        @friendship.destroy
        flash[:notice] = "Removed friendship"
        redirect_to account_path
    end
end
