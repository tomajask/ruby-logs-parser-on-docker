#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../app/environment.rb"
require "optparse"

args = Struct.new(:order).new("visits")

optparse = OptionParser.new do |opts|
  opts.banner = "Usage: parser.rb <required filepath> [options]\n\n"

  opts.on("-o ORDER", "--order=ORDER", "Possible orders: 'visits' and 'unique_visits' (default: 'visits')") do |order|
    args.order = order
  end

  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end
end
optparse.parse!

if ARGV.empty?
  puts optparse
else
  begin
    LogsProcessor.new.process(filepath: File.join("/app", ARGV[0]), sort_by: args.order.to_sym)
  rescue Errno::ENOENT => _e
    puts "Provided file '#{ARGV[0]}' doesn't exist."
  end
end
