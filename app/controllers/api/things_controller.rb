require 'slack'
class Api::ThingsController < ApiController
  def index
    @things = Thing.published.order(created_at: :desc).page(params[:page]).per(params[:per_page] || 3)

    render json: @things, include: params[:include], meta: pagination_dict(@things)
  end

  def show
    @thing = Thing.published.find(params[:id])

    render json: @thing, include: ['comments']
  end

  def create
    @thing = Thing.new(thing_params)

    respond_to do |format|
      if @thing.save
        format.json { render json: @thing, status: :created, location: api_thing_url(@thing) }
        format.html { redirect_to 'https://morgenbladet.no/fiksefest/#/takk' }
      else
        format.json { render json: @thing.errors, status: :unprocessable_entity }
        format.html { redirect_to 'https://morgenbladet.no/fiksefest/#/error' }
      end
    end
  end

  private

  def thing_params
    params.require(:thing).permit(:title, :image, :description, :owner, :email)
  end

  def pagination_dict(collection)
    {
      total_pages: collection.total_pages,
      total_count: collection.total_count,
      prev_page: collection.prev_page,
      next_page: collection.next_page,
      current_page: collection.current_page
    }
  end
end
