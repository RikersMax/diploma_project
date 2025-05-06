# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

=begin
=end
u = User.new(user_name: 'test', email: 'test@email.com')
u.password = 'test'
u.password_confirmation = 'test'
u.save
u.remember_me

TypeObject.create(name_type: 'expense')
TypeObject.create(name_type: 'income')

KindOfObject.create(name_kind: 'personal_object')
KindOfObject.create(name_kind: 'shared_object')


AccountingObject.create(name_object: 'test_object', user_id: u.id, type_object_id: 1, kind_of_object_id: 1)




