class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include CanCan::ControllerAdditions

  before_filter :configure_devise_params, if: :devise_controller?


  def authenticate_current_user
    head :unauthorized if get_current_user.nil?
  end

  def get_current_user
    return nil unless request.cookies['auth_headers']
    auth_headers = JSON.parse request.cookies['auth_headers']

    expiration_datetime = DateTime.strptime(auth_headers["expiry"], "%s")
    current_user = User.find_by(uid: auth_headers["uid"])

    if current_user &&
        current_user.tokens.has_key?(auth_headers["client"]) &&
        expiration_datetime > DateTime.now

      @current_user = current_user
    end

    @current_user
  end

  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) << [:name, :nickname]
  end

  protected
  def self.set_pagination_headers(name, options = {})
    after_filter(options) do |controller|
      results = instance_variable_get("@#{name}")
      headers['X-Pagination'] = {
          total: results.total_entries,
          totalPages: results.total_pages,
          firstPage: results.current_page == 1,
          lastPage: results.next_page.blank?,
          previousPage: results.previous_page,
          nextPage: results.next_page,
          outOfBounds: results.out_of_bounds?,
          offset: results.offset
      }.to_json
    end
  end
end
