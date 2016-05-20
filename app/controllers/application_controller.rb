class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include CanCan::ControllerAdditions
  include ErrorHandlers
  include AuthProtected

  before_action :configure_devise_params, if: :devise_controller?

  # :nocov:
  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) << %i(name nickname)
  end
  # :nocov:

  def self.set_pagination_headers(name, options = {})
    after_action(options) do
      results = instance_variable_get("@#{ name }")
      headers['X-Pagination'] = {
        total: results.total_entries, totalPages: results.total_pages,
        previousPage: results.previous_page, nextPage: results.next_page,
        lastPage: results.next_page.blank?,
        firstPage: results.current_page == 1
      }.to_json
    end
  end
end
