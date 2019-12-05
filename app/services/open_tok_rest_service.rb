class OpenTokRestService
  def self.broadcast(room, user)
    api_key = '46472552';
    api_secret = 'ff08d695fb1f09bddbfdd7abd4ae8c40ad4caa77';
    unless room.session_id.present?
      session = opentok.create_session :media_mode => :routed
      room.update(session_id: session.session_id)
    end
    user.update(otoken: OpenTokRestService.generate_token(room.session_id))
  end

  def self.generate_token(session)
    opentok = OpenTok::OpenTok.new "46472552", "ff08d695fb1f09bddbfdd7abd4ae8c40ad4caa77"
    token = opentok.generate_token session
  end
end
