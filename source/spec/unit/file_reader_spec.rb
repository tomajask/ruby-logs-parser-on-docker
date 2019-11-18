# frozen_string_literal: true

require "spec_helper"

RSpec.describe FileReader do
  let(:instance) { described_class.new(tempfile.path) }

  let(:logs) do
    <<~LOGS
      /help_page/1 126.318.035.038
      /contact 184.123.665.067
      /home 184.123.665.067
      /about/2 444.701.448.104
      /help_page/1 929.398.951.889
      /index 444.701.448.104
    LOGS
  end
  let(:tempfile) { Tempfile.new(SecureRandom.hex) }

  before do
    tempfile.write(logs)
    tempfile.rewind
  end

  after do
    tempfile.close
  end

  it "reads file line by line and removes a newline at the end of line" do
    lines = []
    instance.each { |line| lines << line }
    expect(lines).to eq logs.split("\n")
  end
end
