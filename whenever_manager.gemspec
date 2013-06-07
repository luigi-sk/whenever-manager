$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "whenever_manager/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "whenever_manager"
  s.version     = WheneverManager::VERSION
  s.authors     = ["Lukas Votypka"]
  s.email       = ["lukas.votypka@gmail.com"]
  s.homepage    = "https://github.com/luigi-sk/whenever-manager"
  s.summary     = "TODO: Summary of WheneverManager."
  s.description = "Web manager for whenever definitions with history of changes. Whenever-manager reloads crontab from web app without redeploy of app."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_dependency "whenever", "~> 0.8.2"
  s.add_dependency "coffee-rails"
  s.add_dependency "sass-rails"
  s.add_dependency "paperclip"
  s.add_dependency "jquery-rails"
  s.add_dependency "state_machine"

  s.add_development_dependency "sqlite3"
end
