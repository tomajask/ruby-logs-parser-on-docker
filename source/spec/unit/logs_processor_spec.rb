# frozen_string_literal: true

require "spec_helper"

RSpec.describe LogsProcessor do
  let(:instance) do
    described_class.new(
      storage: storage,
      log_parser: log_parser,
      file_reader: file_reader
    )
  end

  let(:log_parser) do
    instance_double("LogParser", parse_log_line: { parsed: "log" })
  end

  let(:file_reader) do
    class_double("FileReader", new: ["first line", "second_line"])
  end

  let(:storage) do
    instance_double("Storage::InMemory",
                    save: true,
                    all_by_visits: all_by_visits,
                    all_by_unique_visits: all_by_unique_visits)
  end

  let(:all_by_visits) { [["/index", { counter: 10 }]] }
  let(:all_by_unique_visits) { [["/about/2", { visitors: { "123" => 3, "321" => 4 } }]] }
  let(:filepath) { "file/to/path" }

  describe "#process" do
    subject { instance.process(filepath: filepath, sort_by: order) }

    context "when 'sort_by' is unknown" do
      let(:order) { :unknown }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context "when 'sort_by' is defined as 'visits'" do
      let(:order) { :visits }

      it do
        expect { subject }.to output(
          <<~TEXT
            /index 10 visits
          TEXT
        ).to_stdout
      end
    end

    context "when 'sort_by' is defined as 'unique_visits'" do
      let(:order) { :unique_visits }

      it do
        expect { subject }.to output(
          <<~TEXT
            /about/2 2 unique views
          TEXT
        ).to_stdout
      end
    end
  end
end
