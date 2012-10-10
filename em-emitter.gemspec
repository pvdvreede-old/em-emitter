Gem::Specification.new do |s|
  s.name        = 'em-emitter'
  s.version     = '0.9.0.beta.1'
  s.date        = Time.now
  s.summary     = "Global event emitter based on the observer pattern for Eventmachine."
  s.description = "You can use em-emitter to communicate with other objects in the Eventmachine reactor by subscribing to events and emitting them with encapsulated pieces of data."
  s.author      = "Paul Van de Vreede"
  s.email       = 'paul@vdvreede.net'
  s.files       = Dir['lib/**/*.rb']
  s.homepage    = 'https://github.com/pvdvreede/em-emitter'
  s.platform    = Gem::Platform::RUBY

  s.add_runtime_dependency "eventmachine", "~> 1.0"
  s.add_development_dependency "eventmachine", "~> 1.0"
end