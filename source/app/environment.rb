# frozen_string_literal: true

# Load paths for app directory
app_path = File.expand_path(File.join(File.dirname(__FILE__)))
$LOAD_PATH << app_path

# Require dependencies
require "pry"

require "file_reader"
require "storage/in_memory"
