# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


puts "Creating demo accounts..."

admin = User.find_or_create_by(email: 'admin@demo.com') do |user|
  user.password = 'admin123'
  user.password_confirmation = 'admin123'
  user.admin = true
  user.confirmed_at = Time.current
end

demo_user = User.find_or_create_by(email: 'demo@demo.com') do |user|
  user.password = 'demo123'
  user.password_confirmation = 'demo123'
  user.admin = false
  user.confirmed_at = Time.current
end

puts "✅ Demo accounts created!"
puts "Admin: admin@demo.com / admin123"
puts "User: demo@demo.com / demo123"