require 'fileutils'

class Eila
  def initialize(project_name)
    @current_dir  = Dir.pwd
    @project_name = project_name
    
    @dirs = %w(common_data input results lib bin doc test logs)

    @top_dir       = @current_dir + "/" + @project_name
    @unittest_file = @top_dir + "/test/unittest_#{@project_name}.rb"
    @rake_file     = @top_dir + '/Rakefile'
    @config_file   = @top_dir + '/config.yaml'
    @class_file    = @top_dir + '/lib/' + @project_name + ".rb"
    @git_ignore_file = @top_dir + '/.gitignore'
    
    make_top_directory()
    make_sub_directory()
    make_unittest_file()
    make_rake_file()    
    make_config_file()
    make_class_file()
    make_git_ignore_file()    
  end
  attr_reader :project_name

  def make_git_ignore_file  
    out = File.open(@git_ignore_file, "w")
    out.puts <<"EOS"
*~
*.fa
result
EOS
    out.close
  end


  def make_top_directory
    Dir.mkdir(@top_dir) unless FileTest.exist? @top_dir
  end

  def make_sub_directory 
    @dirs.each do |dir|
      subdir = @top_dir + "/" + dir
      Dir.mkdir(subdir) unless FileTest.exist? subdir
    end
  end
  
  def make_unittest_file  

    class_name = @project_name.capitalize
    out = File.open(@unittest_file, "w")
    out.puts <<"EOS"
#!/usr/bin/env ruby

require 'test/unit'
require '#{@project_name}'

class Test_#{class_name} < Test::Unit::TestCase
  def setup
  end
  def test_your_method_name
    assert_equal('expected', 'actual')
  end
end
EOS
    out.close
  end

  def make_rake_file  
    out = File.open(@rake_file, "w")
    out.puts <<"EOS"
require "yaml"
require "pp"

base_dir = Dir.pwd

desc "Run Unit Test"
task :default => [:view_config]

param = ""
File.open("./config.yaml") {|io|
  YAML.load_documents(io) {|obj|
    obj.keys.each do |key|
      param = obj[key]
    end
  }
}

desc \"View configuration of your project\"
task :view_config do
  pp base_dir
  pp param
end    
EOS
    out.close
  end


  def make_config_file  
    out = File.open(@config_file, "w")
    out.puts <<"EOS"
dir:
    results: results
    input: input
    lib: lib
    test: test
    bin: bin
    logs: logs
    doc: doc
    common_data: common_data
EOS
    out.close
  end


  def make_class_file  
    class_name = @project_name.capitalize
    out = File.open(@class_file, "w")
    out.puts <<"EOS"
class #{class_name}
  def initialize()
  end
  attr_reader :project_name
end

if __FILE__ == $0
  #{class_name}.new
end
EOS
    out.close
  end
  
  def make_git_ignore_file
    out = File.open(@git_ignore_file, "w")
    out.puts <<"EOS"
results
input
common_data
*~
EOS
  end
  
end
