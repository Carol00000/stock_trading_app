begin
  puts "Checking database connection..."
  
  if ActiveRecord::Migration.check_pending!
    puts "Running pending migrations..."
  end
rescue => e
  puts "Migration check failed: #{e.message}"
end

puts "Creating demo accounts..."

begin
  admin = User.find_or_create_by(email: 'admin@demo.com') do |user|
    user.password = 'admin123'
    user.password_confirmation = 'admin123'
    user.admin = true
    user.confirmed_at = Time.current
    puts "Creating admin user..."
  end

  demo_user = User.find_or_create_by(email: 'demo@demo.com') do |user|
    user.password = 'demo123'
    user.password_confirmation = 'demo123'
    user.admin = false
    user.confirmed_at = Time.current
    puts "Creating demo user..."
  end

  puts "✅ Demo accounts created successfully!"
  puts "Admin: admin@demo.com / admin123"
  puts "User: demo@demo.com / demo123"
  
rescue => e
  puts "❌ Error creating users: #{e.message}"
  puts "This might be because migrations haven't run yet."
end