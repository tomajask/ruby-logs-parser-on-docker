# frozen_string_literal: true

module Formatters
  class Visits
    def compose(data)
      format(
        "%<path>s %<visits>d visits",
        path: data[0],
        visits: data[1][:counter]
      )
    end
  end
end
