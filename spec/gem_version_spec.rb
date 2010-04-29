require 'lib/gem_version'

$gem_version_file = File.expand_path(File.dirname(__FILE__)) + '/next_gem_version'

describe "GemVersion" do
  describe "next_version method" do
    it "should create an initial 'next_gem_version' file with the version 0.0.1 if none exists" do
      GemVersion.gem_version_file = $gem_version_file
      File.delete($gem_version_file) if File.exists?($gem_version_file)
      File.exists?($gem_version_file).should == false
      GemVersion.next_version.should == '0.0.1'
      File.exists?($gem_version_file).should == true
      File.new($gem_version_file).gets.chomp.should == '0.0.1'
    end
    it "should return the 'next' version from the 'next_gem_version' file" do
      GemVersion.gem_version_file = $gem_version_file
      file = File.new($gem_version_file, 'w')
      version = '111.222.333.444'
      file.puts version
      file.close
      GemVersion.next_version.should == version
    end
    it "should raise exception if version value corrupted in file" do
      GemVersion.gem_version_file = $gem_version_file
      file = File.new($gem_version_file, 'w')
      file.puts '.1.2.'
      file.close
      lambda { GemVersion.next_version }.should raise_exception(/corrupt/)
    end
    it "should raise exception if version value is nil (non-existent)" do
      GemVersion.gem_version_file = $gem_version_file
      File.delete($gem_version_file)
      file = File.new($gem_version_file, 'w')
      file.puts
      file.close
      lambda { GemVersion.next_version }.should raise_exception(/corrupt/)
    end
  end
  describe "increment_version method" do
    it "should increment and store the next version number" do
      GemVersion.gem_version_file = $gem_version_file
      File.delete($gem_version_file)
      file = File.new($gem_version_file, 'w')
      file.puts '1.2.3'
      file.close
      GemVersion.increment_version
      file = File.new($gem_version_file, 'r')
      file.gets.chomp.should == '1.2.4'
    end
    it "should return the 'next' version number" do
      GemVersion.gem_version_file = $gem_version_file
      File.delete($gem_version_file)
      file = File.new($gem_version_file, 'w')
      file.puts '1.2.5'
      file.close
      GemVersion.increment_version.should == '1.2.5'
    end
  end
end