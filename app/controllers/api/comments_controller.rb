class Api::CommentsController < ApiController
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        @thing = @comment.thing
        format.json { render json: @comment.thing, status: :created, location: api_thing_url(@comment.thing) }
        format.html { redirect_to "https://morgenbladet.bo/fiksefest/#/thing/#{@thing.id}" }
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
        format.html { redirect_to "https://morgenbladet.bo/fiksefest/#/thing/#{@thing.id}" }
      end
    end
  end

  private

  def comment_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
