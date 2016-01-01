lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'acts_as_learnable/version'

Gem::Specification.new do |spec|
  spec.name          = 'acts_as_learnable'
  spec.version       = ActsAsLearnable::VERSION
  spec.authors       = ['Dan Kim']
  spec.email         = ['itsdanya@gmail.com']
  spec.summary       = 'A simple way to create flashcards in your app.'
  spec.description   = 'ActsAsLearnable is a Ruby gem for ActiveRecord models. It provides a simple way to create flashcards in your app. It automatically schedules flashcards for review depending on recall quality (1 to 5). You can easily create a Spaced Repetition System (SRS) using this gem.'
  spec.homepage      = 'https://github.com/itsdn/acts_as_learnable'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '~> 4.2'
  spec.add_dependency 'activesupport', '~> 4.2'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.4'
  spec.add_development_dependency 'sqlite3', '~> 1.3'
  spec.add_development_dependency 'byebug', '~> 8.0'
end
