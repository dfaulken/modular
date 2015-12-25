require 'codeclimate-test-reporter'

SimpleCov.start do
  track_files 'modular.rb'
  refuse_coverage_drop
end

CodeClimate::TestReporter.start

require File.join(File.dirname(__FILE__), '..', 'modular')
