# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


10.times do |n|
  r = Result.create!(
        name: "name#{n+1}",
        level: "level#{n+1}",
        feature: "feature#{n+1}",
        description: "description#{n+1}",
        contents: "contents#{n+1}",
        image: "#{n+1}.png",
      )
  3.times do |m|
    r.wise_sayings.create!(
      title: "title#{m+1}",
      description: "description#{m+1}",
      person: "person#{m+1}",
    )
  end
end

# WiseSaying.create!(
#   title: "title#{n+1}",
#   description: "description#{n+1}",
#   person: "person#{n+1}"
# )
# 9.times do |n|
#   Result.create!(
#     name: "name#{n+1}",
#     level: "level#{n+1}",
#     feature: "feature#{n+1}",
#     description: "description#{n+1}",
#     contents: "contents#{n+1}",
#     image: "#{n+1}.png",
#     wise_sayings_id: "#{n+1}"
#   )
# end

