class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include CanCan::ControllerAdditions
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  before_filter :configure_devise_params, if: :devise_controller?

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


  def checking_arguments(params, require_params)
    !params.nil? && (require_params - params.keys).count.zero? && params.values.select(&:blank?).count.zero?
  end

  def missing_arguments(arg)
    render json: {errors: "Missing argument #{arg}"}, status: 400
  end

  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) << [:name, :nickname]
  end

  def not_found
    render json: {errors: 'resource not found'}, status: 404
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
