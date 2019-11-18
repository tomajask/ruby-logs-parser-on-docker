#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../app/environment.rb"

if ARGV.empty?
  puts "Please provide the path to the log file"
else
  begin
    LogsProcessor.new.process(filepath: File.join("/app", ARGV[0]))
  rescue Errno::ENOENT => _e
    puts "Provided file '#{ARGV[0]}' doesn't exist."
  end
end
