# frozen_string_literal: true

class LogParser
  PATH_REGEXP = %r{/[/_0-9a-z]*}.freeze
  IP_REGEXP = %r{\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}}.freeze
  private_constant :PATH_REGEXP, :IP_REGEXP

  def parse_log_line(log_line)
    {
      path: log_line[PATH_REGEXP, 0],
      ip_address: log_line[IP_REGEXP, 0]
    }
  end
end
