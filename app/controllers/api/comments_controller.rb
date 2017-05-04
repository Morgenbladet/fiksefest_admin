class Api::CommentsController < ApiController
  before_action :set_thing

  def create
    @comment = @thing.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.json { render json: @comment.thing, status: :created, location: api_thing_url(@comment.thing) }
        format.html { redirect_to "https://morgenbladet.bo/fiksefest/#/thing/#{@thing.id}" }
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
        format.html { redirect_to "https://morgenbladet.bo/fiksefest/#/thing/#{@thing.id}" }
      end
    end
  end

  private

  def set_thing
    @thing = Thing.find(params[:thing_id])
  end

  def comment_params
    params.require(:comment).permit(:name, :email, :text)
  end
end
