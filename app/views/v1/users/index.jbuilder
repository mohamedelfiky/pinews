json.array!(@users) do |user|
  json.extract! user, :id, :name, :nickname, :email
  json.role user.role.name
end
