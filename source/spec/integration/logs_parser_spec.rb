# frozen_string_literal: true

require "spec_helper"

RSpec.describe LogsProcessor do
  subject { described_class.new.process(filepath: filepath, sort_by: order) }

  let(:filepath) { "data/webserver.log" }

  describe "#process" do
    context "when 'sort_by' is set to 'visits'" do
      let(:order) { :visits }

      it "prints logs summary to stdout" do
        expect { subject }.to output(
          <<~TEXT
            /about/2 90 visits
            /contact 89 visits
            /index 82 visits
            /about 81 visits
            /help_page/1 80 visits
            /home 78 visits
          TEXT
        ).to_stdout
      end
    end

    context "when 'sort_by' is set to 'unique_visits'" do
      let(:order) { :unique_visits }

      it "prints logs summary to stdout" do
        expect { subject }.to output(
          <<~TEXT
            /help_page/1 23 unique views
            /index 23 unique views
            /contact 23 unique views
            /home 23 unique views
            /about/2 22 unique views
            /about 21 unique views
          TEXT
        ).to_stdout
      end
    end

    context "when 'sort_by' is set to unknown" do
      let(:order) { :unknown }

      it "raises an error with the message" do
        expect { subject }.to raise_error(ArgumentError, "This order is not allowed.")
      end
    end
  end
end
