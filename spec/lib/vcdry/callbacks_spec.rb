require "rails_helper"

RSpec.describe "VCDry::DSL" do
  let(:component) { CallbackComponent.new }

  context "supports initializer callbacks" do
    it "is expected to run" do
      component.with_link(to: "#", text: "Example")
      expect(component).to have_instance_variable(:@links, with_value: [{to: "#", text: "Example"}])
    end
  end
end
