require "rails_helper"

RSpec.describe "VCDry::DSL" do
  context "with the :values option" do
    context "with optional: true" do
      it "is expected to allow nil when optional: true" do
        expect { ValuesComponent.new(size: nil) }.not_to raise_error
        expect(ValuesComponent.new(size: nil)).to have_instance_variable(:@size, with_value: nil)
      end
    end

    context "with :default" do
      it "is expected to not to allow an explicitly passed nil" do
        expect { ValuesComponent.new(padding: nil) }.to raise_error(VCDry::InvalidEnumValueError)
      end
    end

    context "with optional: true and :default" do
      it "is expected to allow nil" do
        expect { ValuesComponent.new(margin: nil) }.not_to raise_error
        expect(ValuesComponent.new(margin: nil)).to have_instance_variable(:@margin, with_value: nil)
      end
    end
  end
end
