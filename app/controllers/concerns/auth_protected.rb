module AuthProtected
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_current_user, except: [:index, :show, :count], unless: :devise_controller?
  end


  def authenticate_current_user
    head :unauthorized if get_current_user.nil?
  end

  def get_current_user
    auth_headers = request.cookies['auth_headers'] || request.headers['Authorization']
    return nil unless auth_headers

    auth_headers = JSON.parse(auth_headers)
    expiry, uid, client= auth_headers['expiry'], auth_headers['uid'], auth_headers['client']

    expiration_datetime = DateTime.strptime(expiry, '%s')
    current_user = User.find_by(uid: uid)

    if current_user && current_user.tokens.has_key?(client) && expiration_datetime > DateTime.now
      @current_user = current_user
    end
    @current_user
  end

end