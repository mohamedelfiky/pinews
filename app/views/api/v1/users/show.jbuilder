json.extract! @user, :id, :name, :nickname, :email
json.role @user.role.name
json.articles @user.articles
