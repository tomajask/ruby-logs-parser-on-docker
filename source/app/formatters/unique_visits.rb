# frozen_string_literal: true

module Formatters
  class UniqueVisits
    def compose(data)
      format(
        "%<path>s %<unique_visits>d unique views",
        path: data[0],
        unique_visits: data[1][:visitors].size
      )
    end
  end
end
