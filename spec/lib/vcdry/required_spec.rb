require "rails_helper"

RSpec.describe "VCDry::DSL" do
  context "with required keywords" do
    it "is expected to raise a VCDry::MissingRequiredKeywordError if not specified" do
      expect { RequiredComponent.new }
        .to raise_error(VCDry::MissingRequiredKeywordError)
    end

    it "is expected not to define predicate methods for presence" do
      component = RequiredComponent.new(name: :example, color: :primary)
      expect(component.respond_to?(:name?)).not_to be_truthy
      expect(component.respond_to?(:color?)).not_to be_truthy
    end

    context "and values" do
      it "is expect to raise a VCDry::InvalidEnumValueError if passed an incorrect value" do
        expect { RequiredComponent.new(name: :example, color: :incorrect) }
          .to raise_error(VCDry::InvalidEnumValueError)
      end

      context "with prediate methods for each value" do
        let(:component) { RequiredComponent.new(name: :example, color: :primary) }

        it "is expected to be defined" do
          expect(component.respond_to?(:color_primary?)).to be_truthy
          expect(component.respond_to?(:color_secondary?)).to be_truthy
          expect(component.respond_to?(:color_tertiary?)).to be_truthy
        end

        it "is expect to be truthy when the value was specified" do
          expect(component.color_primary?).to be_truthy
        end

        it "is expected to be falsey when the value was not specified" do
          expect(component.color_secondary?).to be_falsey
          expect(component.color_tertiary?).to be_falsey
        end
      end
    end
  end
end
