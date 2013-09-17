require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new :test do |t|
  t.libs << "test/lib"
  t.pattern = "test/api/**/*_test.rb"
end

Rake::TestTask.new do |t|
  t.name = "test:gui"
  t.libs += ["test/lib", "test/lib/#{RUBY_ENGINE}"]
  t.pattern = "test/gui/**/*_test.rb"
end

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -r opengl"
end
