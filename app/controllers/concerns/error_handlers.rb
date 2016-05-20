module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    before_action :check_arguments, only: %i(create update), unless: :devise_controller?

    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from StandardError, with: :handle_standard_error
  end

  # :nocov:
  def not_found
    render json: { errors: 'resource not found' }, status: :not_found
  end
  # :nocov:

  def handle_standard_error(exception)
    render json: { errors: exception.message }, status: :internal_server_error
  end

  def check_arguments
    resource = controller_name.singularize.to_sym
    missing_arguments(resource) unless params[resource]
  end

  def missing_arguments(arg)
    render json: { errors: "Missing argument #{ arg }" }, status: :bad_request
  end
end
