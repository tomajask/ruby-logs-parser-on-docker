# frozen_string_literal: true

# Load paths for app directory
app_path = File.expand_path(File.join(File.dirname(__FILE__)))
$LOAD_PATH << app_path

# Require dependencies
require "pry"

require "formatters/unique_visits"
require "formatters/visits"
require "formatters/base"
require "file_reader"
require "log_parser"
require "storage/in_memory"
