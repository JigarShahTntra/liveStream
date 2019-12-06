class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy, :start_broadcast, :join_broadcast, :disconnect]
  before_action :check_user, only: [:disconnect]
  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show;end

  def start_broadcast
    token = OpenTokRestService.new(@room).broadcast
    current_user.update(otoken: token)
    @room.update(publisher: current_user.id, status: 'active')
  end

  def join_broadcast
    token = OpenTokRestService.new(@room).generate_token
    current_user.update(otoken: token)
  end

  def disconnect
    if @user.eql?('publisher')
      @room.update(session_id: '', publisher: '', status: 'inactive')
    end
  end
  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to rooms_path
    else
      render :new
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        redirect_to @room, notice: 'Room was successfully updated.'
      else
        render :edit
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    redirect_to rooms_url, notice: 'Room was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id] || params[:room_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:name, :session_id)
    end

    def check_user
      @user = @room.publisher.eql?(current_user.id.to_s) ? 'publisher' : 'subscriber'
    end
end
