json.array!(@pins) do |pin|
  json.extract! pin, :id, :user_id, :article_id
  json.user pin.user.name
  json.article @article.title
end
