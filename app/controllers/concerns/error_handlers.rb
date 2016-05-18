module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    before_filter :check_arguments, only: [:create, :update], unless: :devise_controller?

    rescue_from ActiveRecord::RecordNotFound, :with => :not_found
    rescue_from StandardError, :with => :handle_standard_error
  end

  def not_found
    return render json: {errors: 'resource not found'}, status: :not_found
  end

  def handle_standard_error(exception)
    return render json: {:errors => exception.message}, :status => :internal_server_error
  end

  def check_arguments
    resource = controller_name.singularize.to_sym
    return missing_arguments(resource) unless params[resource]
  end

  def checking_arguments(params, required_params)
    !params.nil? && (required_params - params.keys).count.zero? && params.values.select(&:blank?).count.zero?
  end

  def missing_arguments(arg)
    render json: {errors: "Missing argument #{arg}"}, status: :bad_request
  end
end