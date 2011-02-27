require 'rubygems'
require 'bundler'
require 'bundler/setup'
Bundler::GemHelper.install_tasks

task :default => :test

desc "Run the test suite. Specify individual tests with TEST."
task :test do
  # Add the test directory to the load path so that the test_helper
  # is easily available to all test files.
  $:.unshift File.expand_path("../test", __FILE__)

  files = ENV["TEST"] ? [ENV["TEST'"]] : Dir["test/**/*_test.rb"]
  files.each { |f| load f }
end
