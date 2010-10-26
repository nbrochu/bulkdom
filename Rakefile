require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "bulkdom"
    gem.summary = %Q{An efficient domain name availability bulk checker}
    gem.description = %Q{An efficient domain name availability bulk checker that looks for the presence of DNS Records before querying the Whois Server to save on requests and lower the chance of temporarily getting IP banned.}
    gem.email = "info@nicholasbrochu.com"
    gem.homepage = "http://github.com/nbrochu/bulkdom"
    gem.authors = ["Nicholas Brochu"]
    gem.add_development_dependency "whois", ">= 1.5.1"
    
    gem.files = [
        "lib/bulkdom.rb",
        "lib/bulkdom/domain_list.rb",
        "LICENSE",
        "README.rdoc",
        "VERSION"]

  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "bulkdom #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
