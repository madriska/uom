require 'rubygems' 
require 'rake' 
require 'spec/rake/spectask' 

task :default => [:spec] 

desc "Run all specs" 
Spec::Rake::SpecTask.new('spec') do |t| 
  t.spec_files = FileList['spec/*_spec.rb'] 
end   

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "uom"
    s.summary = "Ruby library for managing physical units of measure"
    s.email = "brad.ediger@madriska.com"
    s.homepage = "http://github.com/bradediger/uom"
    s.description = "Ruby library for managing physical units of measure"
    s.authors = ["Brad Ediger", "Gregory Brown"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

