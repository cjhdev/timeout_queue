require File.expand_path("../lib/timeout_queue/version", __FILE__)
require 'time'

Gem::Specification.new do |s|
  s.name    = "timeout_queue"
  s.version = TimeoutQueue::VERSION
  s.date = Date.today.to_s
  s.summary = "Like Queue but with a pop timeout and a few other things"
  s.author  = "Cameron Harper"
  s.email = "contact@cjh.id.au"
  s.files = Dir.glob("lib/**/*.rb")
  s.license = 'MIT'
  s.test_files = Dir.glob("test/**/*.rb")
  s.add_development_dependency 'rake'
  s.add_development_dependency 'minitest'  
  s.required_ruby_version = '>= 2.0'
  s.homepage = "https://github.com/cjhdev/timeout_queue"
end
