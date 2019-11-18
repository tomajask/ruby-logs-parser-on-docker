# frozen_string_literal: true

require "spec_helper"

RSpec.describe Formatters::UniqueVisits do
  describe "#compose" do
    subject { described_class.new.compose(data) }

    let(:data) do
      ["/index", { visitors: { "123.123.123.123" => 101, "10.10.10.10" => 120 } }]
    end

    it { is_expected.to eq "/index 2 unique views" }
  end
end
