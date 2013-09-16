require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new :test do |t|
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
end

desc "Open an irb session preloaded with this library"
task :console do
  sh "bundle exec irb -rubygems -r opengl"
end
