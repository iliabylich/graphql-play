Fabricator(:user) do
  email { sequence { |i| "email#{i}@email.com" } }
  password { 'password' }
  name { Faker::Name.name }
end