module RequestSpecHelpers
  def json
    JSON.parse(response.body)
  end

  def auth_headers_for(user, extra_headers = {})
    token, _payload = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil)
    extra_headers.merge('Authorization' => "Bearer #{token}")
  end
end
