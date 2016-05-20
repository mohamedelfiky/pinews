module AuthProtected
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_current_user, except: %i(index show count), unless: :devise_controller?
  end

  def authenticate_current_user
    head :unauthorized if detect_current_user.nil?
  end

  def detect_current_user
    auth_headers = request.cookies['auth_headers'] || request.headers['Authorization']
    if auth_headers
      auth_headers = JSON.parse(auth_headers)
      current_user = User.find_by(uid: auth_headers['uid'])

      @current_user = current_user if validate_user_token(current_user, auth_headers['expiry'], auth_headers['client'])
    end
    @current_user
  end

  def validate_user_token(user, expiry, client)
    user && user.tokens.key?(client) && (DateTime.strptime(expiry, '%s') > DateTime.current)
  end
end
