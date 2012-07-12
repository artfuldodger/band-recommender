# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = %W{
  ben
  bryan
  derek
  hunter
  jake
  jen
  jon
  jonm
  kyle
  neal
  peter
  sarah
  sheehan
  stirling
  tania
  tom
}

users.each do |user|
  file_path = File.join(Rails.root, "db/seed_pictures", "#{user}.jpg")
  User.create(username: user, name: user.capitalize, password: user, picture: File.open(file_path))
end
