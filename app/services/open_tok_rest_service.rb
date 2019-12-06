class OpenTokRestService
  def initialize(room)
    @api_key = '46472552';
    @api_secret = 'ff08d695fb1f09bddbfdd7abd4ae8c40ad4caa77';
    @room = room
    @opentok = OpenTok::OpenTok.new @api_key, @api_secret
  end

  def broadcast
    unless @room.session_id.present?
      session = @opentok.create_session :media_mode => :routed
      @room.update(session_id: session.session_id)
    end
    generate_token
  end

  def generate_token
    token = @opentok.generate_token @room.session_id
  end
end
