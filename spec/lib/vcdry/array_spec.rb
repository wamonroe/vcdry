require "rails_helper"

RSpec.describe "VCDry::DSL" do
  context "when specifying arrays" do
    it "is expected to contain nil if optional and no value passed" do
      component = ArrayComponent.new
      expect(component).to have_instance_variable(:@strings, with_value: nil)
    end

    it "is expected to type cast each value in the array" do
      component = ArrayComponent.new(strings: [1, "2"])
      expect(component).to have_instance_variable(:@strings, with_value: %w[1 2])
    end
  end
end
