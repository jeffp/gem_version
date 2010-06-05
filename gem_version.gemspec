# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{gem_version}
  s.version = "0.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jeff Patmon"]
  s.date = %q{2010-06-04}
  s.description = %q{Automated version management for your Gem builds}
  s.email = %q{jpatmon@gmail.com}
  s.files = ["lib/tasks", "lib/tasks/gem_version.rake", "lib/gem_version.rb", "spec/next_gem_version", "spec/spec.opts", "spec/gem_version_spec.rb", "init.rb", "LICENSE", "Rakefile", "README.rdoc", ".gitignore"]
  s.homepage = %q{http://github.com/jeffp/gem_version/tree/master}
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.6")
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Never bother updating the version for your next gem build by hand.  Configured in your Rakefile, gem_version provides the next Gem version and stores it to the repository.}
  s.test_files = ["spec/gem_version_spec.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<git>, [">= 1.2.5"])
    else
      s.add_dependency(%q<git>, [">= 1.2.5"])
    end
  else
    s.add_dependency(%q<git>, [">= 1.2.5"])
  end
end
