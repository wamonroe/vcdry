require "rails_helper"

RSpec.describe "VCDry::DSL" do
  context "with built-in types" do
    it "is expected to type cast boolean values using !!" do
      expect(TypesComponent.new(boolean: "tacos")).to have_instance_variable(:@boolean, with_value: true)
      expect(TypesComponent.new(boolean: true)).to have_instance_variable(:@boolean, with_value: true)
      expect(TypesComponent.new(boolean: false)).to have_instance_variable(:@boolean, with_value: false)
    end

    it "is expected to type cast datetime values using #to_datetime" do
      value = "2023/01/01"
      expect(TypesComponent.new(datetime: value)).to have_instance_variable(:@datetime, with_value: value.to_datetime)
    end

    it "is expected to type cast hash values using #to_h" do
      hash_value = {a: 1}
      array_value = [[:a, 1]]
      expect(TypesComponent.new(hash: hash_value)).to have_instance_variable(:@hash, with_value: hash_value)
      expect(TypesComponent.new(hash: array_value)).to have_instance_variable(:@hash, with_value: hash_value)
    end

    it "is expected to type cast integer values using #to_i" do
      expect(TypesComponent.new(integer: 1)).to have_instance_variable(:@integer, with_value: 1)
      expect(TypesComponent.new(integer: "1")).to have_instance_variable(:@integer, with_value: 1)
    end

    it "is expected to type cast symbol values using #to_sym" do
      expect(TypesComponent.new(symbol: :a)).to have_instance_variable(:@symbol, with_value: :a)
      expect(TypesComponent.new(symbol: "a")).to have_instance_variable(:@symbol, with_value: :a)
    end
  end

  context "with custom types" do
    it "is expected to type cast custom types using passed proc" do
      expect(TypesComponent.new(custom_proc: "value")).to have_instance_variable(:@custom_proc, with_value: "custom value")
    end

    it "is expected to type cast predefined custom types" do
      expect(TypesComponent.new(custom_hash: {})).to have_instance_variable(:@custom_hash, with_type: CustomHash)
    end

    it "is expected to raise an exception if not passed a proc" do
      expect { VCDry::Types.add_type(:custom, "not valid") }.to raise_error(TypeError)
    end
  end

  context "with unknown types" do
    it "is expected to raise an exception" do
      expect { ApplicationComponent.keyword(:bad, :unknown_type) }.to raise_error(VCDry::UnknownTypeError)
    end
  end

  context "without a type" do
    it "is expected to return whatever value is passed" do
      expect(TypesComponent.new(no_type: "string")).to have_instance_variable(:@no_type, with_value: "string")
      expect(TypesComponent.new(no_type: 1)).to have_instance_variable(:@no_type, with_value: 1)
    end
  end
end
