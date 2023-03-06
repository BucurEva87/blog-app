# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create some users
User.create(name: "Tom", photo: "https://randomuser.me/api/portraits/men/60.jpg", bio: "Teacher from Mexico.", posts_counter: 0)
User.create(name: "Lilly", photo: "https://randomuser.me/api/portraits/women/56.jpg", bio: "Teacher from Poland.", posts_counter: 0)
