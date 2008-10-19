Factory.define :user do |f|
  f.username              'foobar'
  f.email                 'foo@example.com'
  f.password              'secret'
  f.password_confirmation 'secret'
end

Factory.define :project do |f|
  f.user { |c| c.association(:user) }
  f.name             'Foo Bar'
  f.description      'Lorem'
  f.last_activity_at Time.now
end

Factory.define :code_snippet do |f|
  f.project { |c| c.association(:project) }
  f.name     'Hello, World'
  f.content  'puts "Hello, World"'
  f.language 'Ruby'
end

Factory.define :palette do |f|
  f.project { |c| c.association(:project) }
  f.name 'Color Theme'
end

Factory.define :color_swatch do |f|
  f.palette { |c| c.association(:palette) }
  f.hex '#FFF'
end

Factory.define :link do |f|
  f.project { |c| c.association(:project) }
  f.name        'Railscasts'
  f.url         'http://railscasts.com'
  f.description 'Free Ruby on Rails Screencasts'
end

Factory.define :note do |f|
  f.project { |c| c.association(:project) }
  f.name    'Foo'
  f.content 'This is a note'
end

Factory.define :photo do |f|
  f.project { |c| c.association(:project) }
  f.name               'Me!'
  f.image_file_name    'me.jpg'
  f.image_content_type 'image/jpeg'
  f.image_file_size    '986123'
  f.image_updated_at   Time.now
end

Factory.define :screenshot do |f|
  f.project { |c| c.association(:project) }
  f.name       'Railscasts Home'
  f.source_url 'http://railscasts.com'
end
