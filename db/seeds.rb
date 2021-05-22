# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

9.times do |n|
  Result.create!(
    name: "name#{n+1}",
    feature: "feature#{n+1}",
    contents: "contents#{n+1}"
  )
end