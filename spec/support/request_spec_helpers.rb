module RequestSpecHelpers
  def json
    JSON.parse(response.body)
  end

  def auth_headers_for(user, extra_headers = {})
    token = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
    { "Authorization" => "Bearer #{token}" }.merge(extra_headers)
  end
end
