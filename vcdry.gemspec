require_relative "lib/vcdry/version"

Gem::Specification.new do |spec|
  spec.name = "vcdry"
  spec.version = VCDry::VERSION
  spec.authors = ["Alex Monroe"]
  spec.email = ["alex@monroepost.com"]

  spec.summary = "DSL for declaring keyword parameters on ViewComponents."
  spec.description = spec.summary
  spec.homepage = "https://github.com/wamonroe/vcdry"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "CHANGELOG.md", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0", "< 8.1"
  spec.add_dependency "view_component", ">= 2.35", "< 4.0"

  spec.add_development_dependency "sqlite3"
end
