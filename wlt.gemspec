
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "wlt/version"

Gem::Specification.new do |spec|
  spec.name          = "wlt"
  spec.version       = Wlt::VERSION
  spec.authors       = ["Mauro Morales"]
  spec.email         = ["contact@mauromorales.com"]

  spec.summary       = %q{Watson Language Translator}
  spec.description   = %q{Wlt is a command line application and API to translate text using the Watson Language Translator service.}
  spec.homepage      = "https://github.com/mauromorales/wlt"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
