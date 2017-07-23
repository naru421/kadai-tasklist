class TaskfilesController < ApplicationController
  before_action :require_user_logged_in 
  before_action :correct_user, only: [:destroy]

  def create
    @taskfile = current_user.taskfiles.build(taskfile_params)
    if @taskfile.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @taskfiles = current_user.feed_taskfiles.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @taskfile.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def taskfile_params
    params.require(:taskfile).permit(:content)
  end
  
  def correct_user
    @taskfile = current_user.taskfiles.find_by(id: params[:id])
    unless @taskfile
      redirect_to root_url
    end
  end
  
end
