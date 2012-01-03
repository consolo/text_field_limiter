Gem::Specification.new do |s|
  s.name = 'text_field_limiter'
  s.version = '1.0.0'
  s.author = 'Andrew Coleman'
  s.email = 'developers@consoloservices.com'
  s.summary = 'Text Field Limiter'
  s.description = 'Limits text fields to lengths specified in the database for ActionView'
  s.homepage = 'https://redmine.consoloservices.com'
  s.require_path = '.'
  s.files = [ 'text_field_limiter.rb' ]
  s.add_dependency 'actionpack', '~> 2.3'
  s.add_dependency 'haml'
end
