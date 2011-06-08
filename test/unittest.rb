#!/usr/bin/env ruby

require 'test/unit'
require 'eila'

class Test_Eila < Test::Unit::TestCase
  def setup
    @class_name = "hoge"
    @dirs = %w(common_data input results lib bin doc test logs)
    system("rm -rf #{@class_name}")

    @class_file = "./#{@class_name}/lib/#{@class_name}.rb"
    @rake_file  = "./#{@class_name}/Rakefile"
    @test_file  = "./#{@class_name}/test/unittest_" + @class_name + ".rb"
    @git_ignore_file  = "./#{@class_name}/.gitignore"
    Eila.new(@class_name)
  end

  # dirs
  def test_dir_file
    @dirs.each do |dir|
#      assert_equal(true, FileTest.exist?("./#{@class_name}/#{dir}") )
      assert( FileTest.exist?("./#{@class_name}/#{dir}") )
    end      
  end
  
  # files
  def test_make_class_file
    assert( FileTest.exist?(@class_file) )
  end
  def test_make_rake_file
    assert( FileTest.exist?(@rake_file) )
  end
  def test_make_test_file
    assert( FileTest.exist?(@test_file) )
  end
  def test_make_git_ingore_file
    assert( FileTest.exist?(@test_file) )
  end
  def test_make_git_ignore_file
    assert( FileTest.exist?("./#{@class_name}/.gitignore") )
  end
end
