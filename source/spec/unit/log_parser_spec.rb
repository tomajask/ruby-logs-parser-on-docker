# frozen_string_literal: true

require "spec_helper"

RSpec.describe LogParser do
  subject { described_class.new.parse_log_line(log_line) }

  context "when in provided format" do
    let(:log_line) { "/help_page/1 126.318.035.038" }
    it { is_expected.to eq(path: "/help_page/1", ip_address: "126.318.035.038") }
  end

  context "when in an opposite order" do
    let(:log_line) { "126.318.035.038 /help_page/1" }
    it { is_expected.to eq(path: "/help_page/1", ip_address: "126.318.035.038") }
  end

  context "when 2 IPs provided" do
    let(:log_line) { "126.318.035.038 /help_page/1 123.123.123.123" }

    it "gets the first IP address" do
      is_expected.to eq(path: "/help_page/1", ip_address: "126.318.035.038")
    end
  end

  context "when 2 paths provided" do
    let(:log_line) { "/help_page/1 126.318.035.038 /about" }

    it "gets the first path" do
      is_expected.to eq(path: "/help_page/1", ip_address: "126.318.035.038")
    end
  end

  context "when timestamp provided" do
    let(:log_line) { "/help_page/1 126.318.035.038 2019-12-25T11:12:13+00:00" }

    it "skips the timestamp" do
      is_expected.to eq(path: "/help_page/1", ip_address: "126.318.035.038")
    end
  end

  context "when delimiter is different than space" do
    let(:log_line) { "/help_page/1,126.318.035.038,2019-12-25T11:12:13+00:00" }

    it "parses the log properly" do
      is_expected.to eq(path: "/help_page/1", ip_address: "126.318.035.038")
    end
  end
end
