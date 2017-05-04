class Api::CommentsController < ApiController

  def show
    @comment = Comment.find(params[:id])

    render json: @comment
  end

  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        @thing = @comment.thing
        format.json { render json: @comment, status: :created, location: api_comment_url(@comment) }
        format.html { redirect_to "https://morgenbladet.bo/fiksefest/#/thing/#{@thing.id}" }
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
        format.html { redirect_to "https://morgenbladet.bo/fiksefest/#/thing/#{@thing.id}" }
      end
    end
  end

  private

  def comment_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(
      params, only: [:name, :email, :text, :thing_id]
    )
  end
end
