class FriendshipsController < ApplicationController

    #show add Friends page
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
        suggestions = Array.new
        possiblesuggestion = User.all
        possiblesuggestion.each do |suggestion|
            if suggestion.id != current_user.id && !@myfriendships.exists?(:friend_id => suggestion.id)
                suggestions.append(suggestion)
            end
        end
        @suggestion = suggestions[0..8]
        render "addFriends"
    end

    #create new friendship
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

    #destroy friendship with id: :id
    def destroy
        @friendship = current_user.friendships.find(params[:id])
        @friendship.destroy
        flash[:notice] = "Removed friendship"
        redirect_to account_path
    end
end
