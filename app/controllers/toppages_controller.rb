class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @taskfile = current_user.taskfiles.build  # form_for 用
      @taskfiles = current_user.taskfiles.order('created_at DESC').page(params[:page])
    end
  end
end
