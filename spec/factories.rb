Factory.define(:user) do |u|
  u.email "joe@example.com"
  u.name "Joe Example"
  u.password "password"
  u.password_confirmation "password"
end

Factory.define(:project) do |p|
  p.name "Blog"
  p.api_key "abcd1234"
end

Factory.define(:actor) do |a|
  a.name "User"
  a.description "Someone who does stuff"
end