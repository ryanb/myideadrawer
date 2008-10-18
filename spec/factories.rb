Factory.define :user do |f|
  f.username              'foobar'
  f.email                 'foo@example.com'
  f.password              'secret'
  f.password_confirmation 'secret'
end

Factory.define :project do |f|
  f.name             'Foo Bar'
  f.description      'Lorem'
  f.last_activity_at Time.now
end
