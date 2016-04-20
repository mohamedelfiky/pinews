admin_role = Role.find_or_create_by({name: 'Admin'})
Role.find_or_create_by({name: 'Author'})

puts 'Creating admin account ...'
admin= User.find_by_email('admin@pinews.com')
unless admin
  admin = User.new({
                     email: 'admin@pinews.com',
                     nickname: 'admin',
                     name: 'admin',
                     password: '@dm!N123',
                     role_id: admin_role.id,
                     confirmed_at: Date.today
                 })
  admin.save!
  admin.create_new_auth_token
end


puts 'Creating Articles ...'
Article.destroy_all
(1..10).each do
  Article.create({
                     title: Faker::Name.title,
                     description: Faker::Hipster.paragraph(2),
                     image: Faker::Avatar.image,
                     author_id: admin.id
                 })
end
