# frozen_string_literal: true

require_relative "lib/ecase/version"

Gem::Specification.new do |spec|
  spec.name = "ecase"
  spec.version = Ecase::VERSION
  spec.authors = ["Joel Drapper"]
  spec.email = ["joel@drapper.me"]

  spec.summary = "Exhaustive case statements for Ruby."
  spec.description = "Exhaustive case statments that ensure all possible cases are covered."
  spec.homepage = "https://github.com/joeldrapper/ecase"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/joeldrapper/ecase"
  spec.metadata["changelog_uri"] = "https://github.com/joeldrapper/ecase"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
