class CommentsController < ApplicationController
  before_action :set_comment

  # PATCH /comments/1
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment.thing, notice: 'Kommentaren ble oppdatert' }
      else
        format.html { redirect_to @comment.thing, notice: 'Kommentaren kunne ikke lagres.' }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @comment.thing, notice: 'Kommentaren ble slettet.' }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:thing_id, :text, :name, :email, :published)
  end
end
