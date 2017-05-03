class Api::ThingsController < ApiController
  respond_to :json

  def index
    @n = params[:n].try(:to_i) || 6
    @n=6 if @n > 10

    @things = Thing.published.order("RANDOM()").first(@n)
  end

  def show
    @thing = Thing.find(params[:id])
  end

  def create
    @thing = Thing.new(thing_params)

    respond_to do |format|
      if @thing.save
        format.json { render :show, status: :created, location: api_thing_url(@thing) }
      else
        format.json { render json: @thing.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def thing_params
    params.require(:thing).permit(:title, :image, :description, :owner, :email)
  end

end
