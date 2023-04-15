require "rails_helper"

RSpec.describe "VCDry::DSL" do
  let(:component) { DefaultComponent.new }

  context "when specifying defaults" do
    it "is expected to allow a simple value" do
      expect(component).to have_instance_variable(:@string, with_value: "default")
    end

    it "is expected to allow a proc" do
      expect(component).to have_instance_variable(:@another_string, with_value: "default")
    end
  end
end
