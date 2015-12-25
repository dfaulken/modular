require 'codeclimate-test-reporter'

SimpleCov.start do
  track_files 'modular.rb'
end

CodeClimate::TestReporter.start

require File.join(File.dirname(__FILE__), '..', 'modular')
