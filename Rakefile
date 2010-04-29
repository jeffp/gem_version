#require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'gem_versions'
#require 'rake/contrib/sshpublisher'
require 'lib/gem_version'

spec = Gem::Specification.new do |s|
  s.name = 'gem_version'
  s.version = GemVersion.next_version
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 1.8.6'
  s.description = 'Gem version management for Gem builds'
  s.summary = 'No need to update the gem version for your builds by hand.  Gem version manages it for you.'

  s.add_dependency('git', '>= 1.2.5')  
  
  exclude_folders = '' # 'spec/rails/{doc,lib,log,nbproject,tmp,vendor,test}'
  exclude_files = [] # FileList['**/*.log'] + FileList[exclude_folders+'/**/*'] + FileList[exclude_folders]
  s.files = FileList['{lib,spec}/**/*'] + %w(init.rb LICENSE Rakefile README.rdoc .gitignore) - exclude_files
  s.require_path = 'lib'
  s.has_rdoc = true
  s.test_files = Dir['spec/*_spec.rb']
  
  s.author = 'Jeff Patmon'
  s.email = 'jpatmon@gmail.com'
  s.homepage = 'http://github.com/jeffp/gem_version/tree/master'
end
 
require 'spec/version'
require 'spec/rake/spectask'

desc "Run specs"
namespace :spec do
	task :default=>:object
	Spec::Rake::SpecTask.new(:object) do |t|
		t.spec_files = FileList['spec/*_spec.rb']
		t.libs << 'lib' << 'spec'
		t.rcov = false
		t.spec_opts = ['--options', 'spec/spec.opts']
		#t.rcov_dir = 'coverage'
		#t.rcov_opts = ['--exclude', "kernel,load-diff-lcs\.rb,instance_exec\.rb,lib/spec.rb,lib/spec/runner.rb,^spec/*,bin/spec,examples,/gems,/Library/Ruby,\.autotest,#{ENV['GEM_HOME']}"]
	end
=begin
	Spec::Rake::SpecTask.new(:sub) do |t|
		t.spec_files = FileList['spec/inheritance_spec.rb']
		t.libs << 'lib' << 'spec'
		t.rcov = false
		t.spec_opts = ['--options', 'spec/spec.opts']
	end
	Spec::Rake::SpecTask.new(:poro) do |t|
		t.spec_files = FileList['spec/poro_spec.rb']
		t.libs << 'lib' << 'spec'
		t.rcov = false
		t.spec_opts = ['--options', 'spec/spec.opts']
	end

  desc "Run ActiveRecord integration specs"
	Spec::Rake::SpecTask.new(:active_record) do |t|
		t.spec_files = FileList['spec/active_record/*_spec.rb']
		t.libs << 'lib' << 'spec/active_record'
		t.spec_opts = ['--options', 'spec/spec.opts']    
		t.rcov = false
	end
	Spec::Rake::SpecTask.new(:forms) do |t|
		t.spec_files = FileList['spec/rails/spec/integrations/*_spec.rb']
		t.libs << 'lib' << 'spec/rails/spec'
		t.spec_opts = ['--options', 'spec/spec.opts']    
		t.rcov = false
	end
#	Spec::Rake::SpecTask.new(:associations) do |t|
#		t.spec_files = FileList['spec/active_record/associations_spec.rb']
#		t.libs << 'lib' << 'spec/active_record'
#		t.rcov = false
#	end
	desc "Run all specs"
	task :all=>[:object, :active_record, :forms]
=end
end


desc "Generate documentation for the #{spec.name} gem."
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = spec.name
  #rdoc.template = '../rdoc_template.rb'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc', 'LICENSE', 'lib/**/*.rb')
end
 
desc 'Generate a gemspec file.'
task :gemspec do
  File.open("#{spec.name}.gemspec", 'w') do |f|
    f.write spec.to_ruby
  end
  GemVersion.increment_version
  GemVersion.commit_and_push
end
 
Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = RUBY_PLATFORM =~ /mswin/ ? false : true
  p.need_zip = true
end

Dir['tasks/**/*.rake'].each {|rake| load rake}