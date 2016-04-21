json.extract! @article, :id, :title, :description, :created_at
json.image Rails.configuration.root_url + @article.image.url(:medium)
json.author do
  json.name @article.author.name
  json.email @article.author.email
end
json.role @article.author.role.name
