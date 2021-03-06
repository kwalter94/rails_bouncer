$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "rails_bouncer/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "rails_bouncer"
  spec.version     = RailsBouncer::VERSION
  spec.authors     = ["Walter Kaunda"]
  spec.email       = ["walterkaunda@live.co.uk"]
  spec.homepage    = "https://gitlab.com/kwalter94/rails-bouncer"
  spec.summary     = "An authorization plugin for Rails"
  spec.description = "Rails authorization partly inspired by pundit (https://github.com/varvet/pundit)."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    # TODO: Release the Kraken! (ie when ready for that awesome life)
    # spec.metadata["allowed_push_host"] = "http://mygemserver.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.3", ">= 6.0.3.2"

  spec.add_development_dependency "sqlite3"
end
