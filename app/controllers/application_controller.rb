class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include CanCan::ControllerAdditions

  before_action :configure_devise_params, if: :devise_controller?
  before_action :check_arguments, only: %i(create update), unless: :devise_controller?
  before_action :authenticate_current_user, except: %i(index show count), unless: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from StandardError, with: :handle_standard_error

  def authenticate_current_user
    head :unauthorized if detect_current_user.nil?
  end

  def detect_current_user
    auth_headers = request.cookies['auth_headers'] || request.headers['Authorization']
    return nil unless auth_headers

    auth_headers = JSON.parse(auth_headers)
    expiry, uid, client = auth_headers['expiry'], auth_headers['uid'], auth_headers['client']

    expiration_datetime = DateTime.strptime(expiry, '%s')
    current_user = User.find_by(uid: uid)

    if current_user && current_user.tokens.key?(client) && expiration_datetime > DateTime.current
      @current_user = current_user
    end
    @current_user
  end

  def missing_arguments(arg)
    render json: { errors: "Missing argument #{ arg }" }, status: :bad_request
  end

  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) << %i(name nickname)
  end

  def not_found
    render json: { errors: 'resource not found' }, status: :not_found
  end

  def handle_standard_error(exception)
    render json: { errors: exception.message }, status: :internal_server_error
  end

  protected

  def self.set_pagination_headers(name, options = {})
    after_action(options) do
      results = instance_variable_get("@#{ name }")
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

  def check_arguments
    resource = controller_name.singularize.to_sym
    return missing_arguments(resource) unless params[resource]
  end
end
