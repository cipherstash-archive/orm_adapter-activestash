begin
  require "git-version-bump"
rescue LoadError
  nil
end

Gem::Specification.new do |s|
  s.name = "orm_adapter-activestash"

  s.version = GVB.version rescue "0.0.0.1.NOGVB"
  s.date    = GVB.date    rescue Time.now.strftime("%Y-%m-%d")

  s.platform = Gem::Platform::RUBY

  s.summary  = "orm_adapter backend for ActiveStash"

  s.authors  = ["Matt Palmer"]
  s.email    = ["matt@cipherstash.com"]
  s.homepage = "https://cipherstash.com/activestash"

  s.files = `git ls-files -z`.split("\0").reject { |f| f =~ /^(G|spec|Rakefile)/ }

  s.required_ruby_version = ">= 2.7.0"

  s.metadata["homepage_uri"] = s.homepage
  s.metadata["source_code_uri"] = "https://github.com/cipherstash/orm_adapter-activestash"
  s.metadata["changelog_uri"] = "https://github.com/cipherstash/orm_adapter-activestash/releases"
  s.metadata["bug_tracker_uri"] = "https://github.com/cipherstash/orm_adapter-activestash/issues"
  s.metadata["documentation_uri"] = "https://rubydoc.info/gems/orm_adapter-activestash"
  s.metadata["mailing_list_uri"] = "https://discuss.cipherstash.com"

  s.add_runtime_dependency "active_stash", "~> 0.0"
  s.add_runtime_dependency "orm_adapter", "~> 0.5"

  s.add_development_dependency "bundler", "~> 2.0"
  s.add_development_dependency "github-release", "~> 0.2"
  s.add_development_dependency "git-version-bump", "~> 0.17"
  s.add_development_dependency "rake", "~> 13.0"
  s.add_development_dependency "redcarpet", "~> 3.0"
  # Need to lock `uri` at this version to prevent autobuild failures.
  # NFI why this doesn't also cause problems locally, but bundler gonna bundler.
  s.add_development_dependency "uri", "0.10.0"
  s.add_development_dependency "yard", "~> 0.9"
end
