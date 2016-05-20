module Requests
  @current_user = nil

  def json
    if response.status != 204
      JSON.parse(response.body)
    else
      true
    end
  end

  def user
    @current_user = create(:user, :admin) unless @current_user
    @current_user
  end

  def user_header
    { 'Authorization' => user.create_new_auth_token.to_json }
  end
end
