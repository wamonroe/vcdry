require "rails_helper"

RSpec.describe "VCDry::DSL" do
  context "when unknown keywords specified" do
    it "is expected to raise an exception" do
      expect { ApplicationComponent.new(unknown_keyword: "value") }.to raise_error(VCDry::UnknownArgumentError)
    end

    it "is expected not to raise an exception .strict_keywords(false)" do
      expect { NonStrictKeywordsComponent.new(unknown: "value") }.not_to raise_error
    end
  end
end
