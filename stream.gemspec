$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'stream'

Gem::Specification.new do |s|
  s.name    = 'Stream'
  s.version = STREAM_VERSION
  s.summary = "Stream - Extended External Iterators"
  s.description = "Module Stream defines an interface for external iterators."

  #### Dependencies and requirements.

  s.add_development_dependency 'rake'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'test-unit'

  #### Which files are to be included in this gem?

  s.files = Dir[
    '[A-Z]*',
    'lib/**/*.rb',
    'test/**/*.rb',
    'examples/**/*',
    'Gemfile',
    'README.rdoc',
    'Rakefile'
  ]

  #### Load-time details: library and application (you will need one or both).

  s.require_path = 'lib'
  s.autorequire  = 'stream'

  #### Documentation and testing.

  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc']
  s.rdoc_options += [
      '--title', s.summary,
      '--main', 'README.rdoc',
      '--line-numbers'
  ]

  #### Author and project details.

  s.authors           = [ "Horst Duchene" ]
  s.email             = "monora@gmail.com"
  s.homepage          = "https://github.com/monora/stream"
end
