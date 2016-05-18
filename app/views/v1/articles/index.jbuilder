json.array!(@articles) do |article|
  json.extract! article, :id, :title, :description, :created_at
  json.image Rails.configuration.root_url + article.image.url(:medium)
  json.author article.author.name
  json.role article.author.role.name
end
