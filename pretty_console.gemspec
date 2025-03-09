lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pretty_console/version'

Gem::Specification.new do |s|
  s.name        = "pretty_console"
  s.version     = PrettyConsole::VERSION
  s.description = "A simple gem to colorize your console output"
  s.summary     = s.description
  s.authors     = ["Etienne Weil"]
  s.email       = "weil.etienne@hotmail.fr"
  s.files       = `git ls-files`.split($/)
  s.test_files  = s.files.grep(%r{^(test|spec|features)/})
  s.homepage    = "https://rubygems.org/gems/pretty_console"
  s.license     = "MIT"
  s.metadata    = { "source_code_uri" => "https://github.com/fitchMitch/pretty_console" }
end