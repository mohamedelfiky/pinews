module RoutesHelper
  def routes_for(resource, args = {})
    # set defaults
    api_version = 1
    parents = []

    api_version = args[:api_version] if args.key?(:api_version)
    parents = args[:parents] if args.key?(:parents)

    plural = resource.to_s.pluralize
    plural_path = "#{plural}_path".to_sym

    let(plural_path) do
      routes = parents.collect { |r| add_parent_route(r) }.join
      "/api/v#{ api_version }/#{ routes }#{ plural }/".gsub(%r{(?<!:)//}, '/')
    end

    let("#{resource}_path".to_sym) do
      add_parent_route(resource, plural_path).gsub(%r{(?<!:)//}, '/')
    end
  end
end

module ActionDispatch::TestProcess

  def add_parent_route(parent_resource, plural_path = nil)
    if respond_to?(parent_resource)
      parents = send(plural_path) if plural_path
      "#{ parents || parent_resource.to_s.pluralize }/#{ send(parent_resource).id }/"
    else
      puts "#{parent_resource} is not defined"
      ''
    end
  end
end