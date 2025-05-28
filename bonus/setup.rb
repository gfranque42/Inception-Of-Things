user = User.find_by_username('root')
token = user.personal_access_tokens.create(
    name: 'bobyy',
    scopes: [:api],
    expires_at: 1.year.from_now
)
token.save!
puts "Your token: #{token.token}"
