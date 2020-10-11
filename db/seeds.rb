# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Book.destroy_all
StudentBook.destroy_all 

c = User.create(username: "chsohn")

b = Book.create(title: "Catcher")

sb = StudentBook.create(book: b, student: c)

tc = Character.create(name: "Thomas Cromwell", image_url: "https://spartacus-educational.com/00cromwellEX1.jpg")

h8 = Character.create(name: "Henry VIII", image_url: "https://cdn.britannica.com/75/192075-050-0C3D74AC/oil-Henry-VIII-wood-Hans-Holbein-the.jpg")

hc = Character.create(name: "Holden Caulfield", image_url: "https://hips.hearstapps.com/esq.h-cdn.co/assets/15/39/1443043689-the-catcher-in-the-rye-by-mscorley-d3gop5m.jpg")

jg = Character.create(name: "Jane Gallagher", image_url: "https://pbs.twimg.com/profile_images/692706855701708800/dRWMlEyh_400x400.jpg")