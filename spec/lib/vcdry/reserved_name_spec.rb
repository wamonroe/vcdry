require "rails_helper"

RSpec.describe "VCDry::DSL" do
  context "when using a reserved keyword" do
    it "is expected to raise a VCDry::ReservedNameError" do
      expect { OtherKeywordsComponent.keyword :options }
        .to raise_error(VCDry::ReservedNameError)
    end
  end
end
