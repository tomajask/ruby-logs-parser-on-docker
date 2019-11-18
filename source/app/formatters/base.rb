# frozen_string_literal: true

module Formatters
  class Base
    def self.for(type)
      {
        all_by_visits: Formatters::Visits.new,
        all_by_unique_visits: Formatters::UniqueVisits.new
      }.fetch(type) { raise "This type is not allowed." }
    end
  end
end
