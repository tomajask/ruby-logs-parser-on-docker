# frozen_string_literal: true

module Storage
  class InMemory
    def initialize
      @storage = {}
    end

    def save(log_entry)
      path, ip_address = log_entry[:path], log_entry[:ip_address]
      storage[path] ||= entry_template.dup

      storage[path].tap do |entry|
        entry[:counter] += 1
        entry[:visitors] ||= Hash.new(0)
        entry[:visitors][ip_address] += 1
      end
    end

    def all_by_visits
      storage.sort_by { |_path, data| data[:counter] }.reverse
    end

    def all_by_unique_visits
      storage.sort_by { |_path, data| data[:visitors].size }.reverse
    end

    private

    attr_reader :storage

    def entry_template
      {
        counter: 0,
        visitors: nil
      }
    end
  end
end
