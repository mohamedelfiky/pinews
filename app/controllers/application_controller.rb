class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include CanCan::ControllerAdditions
  include ErrorHandlers
  include AuthProtected

  before_action :configure_devise_params, if: :devise_controller?

  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) << %i(name nickname)
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

end
