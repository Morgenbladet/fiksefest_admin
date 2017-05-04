class Api::ThingsController < ApiController
  def index
    @n = params[:n].try(:to_i) || 6
    @n=6 if @n > 10

    @things = Thing.published.order("RANDOM()").first(@n)

    render json: @things, include: ['comments']
  end

  def show
    @thing = Thing.find(params[:id])

    render json: @thing, include: ['comments']
  end

  def create
    @thing = Thing.new(thing_params)

    respond_to do |format|
      if @thing.save
        ThingsMailer.submitted(@thing).deliver_now
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

end
