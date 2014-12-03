class CommentsController < ApplicationController

    def create
        @task = Task.find(params[:comment][:task_id])        
        @comment = Comment.new(comment_params)
        @comment.save
        redirect_to  url_for(:controller => 'tasks', :action => 'event', :id => @task.id)
    end

    private
        def comment_params
          params.require(:comment).permit(:text, :username, :task_id)
        end
end
