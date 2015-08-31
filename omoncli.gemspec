# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','omoncli','version.rb'])

spec = Gem::Specification.new do |s|
  s.name = 'omoncli'
  s.version = Omoncli::VERSION
  s.author = 'Andrii Romashchenko'
  s.email = 'a.romaschenko@gmail.com'
  s.homepage = 'http://your.website.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A description of your project'
  s.files += Dir.glob('bin/**/*')
  s.files += Dir.glob('lib/**/*.rb')
  s.files += Dir.glob('lib/**/*.erb')
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','omoncli.rdoc']
  s.rdoc_options << '--title' << 'omoncli' << '--main' << 'README.rdoc'
  s.bindir = 'bin'
  s.executables << 'omoncli'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_runtime_dependency('thor')
  s.add_runtime_dependency('highline')
end
