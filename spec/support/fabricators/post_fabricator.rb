Fabricator(:post) do
  user
  title { sequence { |i| "title#{i}" } }
  body { sequence { |i| "body#{i}" } }
end
