# frozen_string_literal: true

require "spec_helper"

RSpec.describe Formatters::Base do
  describe ".for" do
    subject { described_class.for(type) }

    context "when type is 'all_by_visits'" do
      let(:type) { :all_by_visits }
      it { is_expected.to be_instance_of(Formatters::Visits) }
    end

    context "when type is 'all_by_unique_visits'" do
      let(:type) { :all_by_unique_visits }
      it { is_expected.to be_instance_of(Formatters::UniqueVisits) }
    end

    context "when type is unknown" do
      let(:type) { :unknown }
      it { expect { subject }.to raise_error("This type is not allowed.") }
    end
  end
end
