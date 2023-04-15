require "rails_helper"

RSpec.describe "VCDry::DSL" do
  let(:component) { OptionalComponent.new(color: :primary) }

  context "with optional keywords" do
    it "is expected not to raise an if not specified" do
      expect { OptionalComponent.new }.not_to raise_error
    end

    it "is expected to define predicate methods for presence" do
      expect(component.respond_to?(:name?)).to be_truthy
      expect(component.respond_to?(:color?)).to be_truthy
    end

    it "is expected to be truthy when a value was specified" do
      expect(component.color?).to be_truthy
    end

    it "is expected to be falsey when a value was not specified" do
      expect(component.name?).to be_falsey
    end

    context "and values" do
      it "is expect to raise a VCDry::InvalidEnumValueError if passed an incorrect value" do
        expect { OptionalComponent.new(color: :incorrect) }
          .to raise_error(VCDry::InvalidEnumValueError)
      end

      context "with prediate methods for each value" do
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
