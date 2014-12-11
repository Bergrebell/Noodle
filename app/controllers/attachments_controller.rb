class AttachmentsController < ApplicationController
  
  #Download file with id: :a_id
  def show
    @attachment = Attachment.where(id: params[:a_id]).first
    p @attachment
    send_data @attachment.data, :filename => @attachment.filename, :type => @attachment.content_type
  end

    #initiate file upload
    def create
    return if params[:attachment].blank?

    @attachment = Attachment.new
    @attachment.uploaded_file(params[:attachment].first.second, params[:attachment][:task_id])

        if @attachment.save
            flash[:notice] = "Thank you for your submission..."
            redirect_to  url_for(:controller => 'tasks', :action => 'event', :id => params[:attachment][:task_id])
        else
            flash[:error] = "There was a problem submitting your attachment."
            redirect_to  url_for(:controller => 'tasks', :action => 'event', :id => params[:attachment][:task_id])
        end
    end

end
