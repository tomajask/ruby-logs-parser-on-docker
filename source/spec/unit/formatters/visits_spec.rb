# frozen_string_literal: true

require "spec_helper"

RSpec.describe Formatters::Visits do
  describe "#compose" do
    subject { described_class.new.compose(data) }

    let(:data) do
      ["/about", { counter: 101 }]
    end

    it { is_expected.to eq "/about 101 visits" }
  end
end
