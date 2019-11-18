# frozen_string_literal: true

class LogsProcessor
  def initialize(storage: nil, file_reader: nil, log_parser: nil)
    @storage = storage || Storage::InMemory.new
    @file_reader = file_reader || FileReader
    @log_parser = log_parser || LogParser.new
    @base_formatter = Formatters::Base
  end

  def process(filepath:, sort_by: :visits)
    order = available_orders(sort_by)
    parse_and_store_logs(filepath)
    logs = fetch_logs_by(order)
    formatter = base_formatter.for(order)
    print(logs, formatter)

    true
  end

  private

  attr_reader :storage, :file_reader, :log_parser, :base_formatter

  def available_orders(order)
    {
      visits: :all_by_visits,
      unique_visits: :all_by_unique_visits
    }.fetch(order) { raise ArgumentError, "This order is not allowed." }
  end

  def parse_and_store_logs(filepath)
    file_reader.new(filepath).each do |line|
      storage.save(log_parser.parse_log_line(line))
    end
  end

  def fetch_logs_by(order)
    storage.public_send(order)
  end

  def print(logs, formatter)
    logs.each do |log_entry|
      puts formatter.compose(log_entry)
    end
  end
end
