require 'rubygems'
require 'git'
require 'logger'

module GemVersion
  @@gem_version_file = 'next_gem_version'
  @@default_commit_message = 'incremented gem version'

  def self.next_version
    init_version_file unless File.exists?(@@gem_version_file)
    File.new(@gem_version_file, 'r') do |f|
      return f.gets.chomp
    end.close
  end

  def self.init_version_file
    File.new(@gem_version_file, 'w') do |f|
      f.puts '0.0.1'
    end.close
  end

  def self.increment_version
    version = self.next_version
    components = version.split('.')
    components.push((components.pop.to_i + 1).to_s)
    new_version = components.join('.')
    File.new('next_gem_version', 'w') do |f|
      f.puts new_version
    end.close
    version
  end

  def commit_and_push(msg = nil)
    g=Git.open(File.dirname(__FILE__), :log=>Logger.new(STDOUT))
    g.add(@gem_version_file)
    g.commit(msg || @@default_commit_message)
    g.push
  end
end
