class WelcomeController < ApplicationController

  def new
    @testtask = Task.new
  end


  def create
    @testtask = Task.new(task_params)
    logger.debug "New post: #{@testtask.attributes.inspect}"
    logger.debug "Post should be valid: #{@testtask.valid?}"
    @testtask.save
  end

  private
  def task_params
    params.permit(:title, :text)
  end

end
