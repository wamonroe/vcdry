require "rails_helper"

RSpec.describe "VCDry::DSL" do
  context "with unknown keywords" do
    context "and .other_keywords" do
      let(:component) { OtherKeywordsComponent.new(name: "Example", class: "mt-1 mb-1") }

      it "is expected save to the specified variable" do
        expect(component).to have_instance_variable(:@options, with_value: {class: "mt-1 mb-1"})
      end

      it "is expected to save specified keywords" do
        expect(component).to have_instance_variable(:@name, with_value: "Example")
      end
    end
  end
end
