# frozen_string_literal: true

require "spec_helper"

RSpec.describe Storage::InMemory do
  let(:instance) { described_class.new }

  let(:log_entry1) { { path: "/help_page/1", ip_address: "722.247.931.582" } }
  let(:log_entry2) { { path: "/help_page/1", ip_address: "722.247.931.582" } }
  let(:log_entry3) { { path: "/help_page/2", ip_address: "646.865.545.408" } }
  let(:log_entry4) { { path: "/index", ip_address: "126.318.035.038" } }
  let(:log_entry5) { { path: "/index", ip_address: "929.398.951.889" } }

  describe "#save" do
    it "stores log entries properly" do
      expect(instance.save(log_entry1)).to eq(counter: 1, visitors: { "722.247.931.582" => 1 })
      expect(instance.save(log_entry2)).to eq(counter: 2, visitors: { "722.247.931.582" => 2 })
      expect(instance.save(log_entry3)).to eq(counter: 1, visitors: { "646.865.545.408" => 1 })
      expect(instance.save(log_entry4)).to eq(counter: 1, visitors: { "126.318.035.038" => 1 })
      expect(instance.save(log_entry5)).to eq(
        counter: 2,
        visitors: {
          "126.318.035.038" => 1,
          "929.398.951.889" => 1
        }
      )
    end
  end

  describe "#all_by_visits" do
    subject { instance.all_by_visits }

    before do
      instance.save(log_entry1)
      instance.save(log_entry1)
      instance.save(log_entry2)
      instance.save(log_entry3)
      instance.save(log_entry4)
      instance.save(log_entry5)
    end

    it "returns all stored objects" do
      is_expected.to eq([
        ["/help_page/1", { counter: 3, visitors: { "722.247.931.582" => 3 } }],
        ["/index", { counter: 2, visitors: { "126.318.035.038" => 1, "929.398.951.889" => 1 } }],
        ["/help_page/2", { counter: 1, visitors: { "646.865.545.408" => 1 } }]
      ])
    end
  end

  describe "#all_by_unique_visits" do
    subject { instance.all_by_unique_visits }

    before do
      instance.save(log_entry1)
      instance.save(log_entry2)
      instance.save(log_entry3)
      instance.save(log_entry4)
      instance.save(log_entry5)
    end

    it "returns all stored objects" do
      is_expected.to eq([
        ["/index", { counter: 2, visitors: { "126.318.035.038" => 1, "929.398.951.889" => 1 } }],
        ["/help_page/2", { counter: 1, visitors: { "646.865.545.408" => 1 } }],
        ["/help_page/1", { counter: 2, visitors: { "722.247.931.582" => 2 } }]
      ])
    end
  end
end
