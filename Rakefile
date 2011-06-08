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

desc "View configuration"
task :view_config do
  pp base_dir
  pp param
end
