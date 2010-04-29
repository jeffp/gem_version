require 'rubygems'
require 'git'
require 'logger'

module GemVersion
  @@gem_version_file = 'next_gem_version'
  @@default_commit_message = 'incremented gem version'

  def self.gem_version_file=(str)
    @@gem_version_file = str
  end

  def self.next_version
    init_version_file unless File.exist?(@@gem_version_file)
    file = File.new(@@gem_version_file, 'r')
    version = file.gets.chomp
    raise "#{@@gem_version_file} file corrupt" unless (version && version =~ /^\d+\.\d+[\.\d+]+$/)
    file.close
    version
  end

  def self.init_version_file
    file = File.new(@@gem_version_file, 'w')
    file.puts '0.0.1'
    file.close
  end

  def self.increment_version
    version = self.next_version
    components = version.split('.')
    components.push((components.pop.to_i + 1).to_s)
    new_version = components.join('.')
    file = File.new(@@gem_version_file, 'w')
    file.puts new_version
    file.close
    version
  end

  def self.commit_and_push(msg = nil)
    g=Git.open(File.dirname(__FILE__), :log=>Logger.new(STDOUT))
    g.add(@@gem_version_file)
    g.commit(msg || @@default_commit_message)
    g.push
  end
end
