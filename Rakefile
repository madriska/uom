require 'rubygems' 
require 'rake' 
require 'spec/rake/spectask' 

task :default => [:spec] 

desc "Run all specs" 
Spec::Rake::SpecTask.new('spec') do |t| 
  t.spec_files = FileList['spec/*_spec.rb'] 
end   

