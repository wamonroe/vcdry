require "rails_helper"

RSpec.describe "VCDry::DSL" do
  let(:parent) { ParentComponent.new(name: "Phillip") }
  let(:child) { ChildComponent.new(name: "Douglass", age: 7, class: "mt-1") }

  it "is expected to pass definitions down to children components" do
    expect(child).to have_instance_variable(:@name)
    expect(child).to have_instance_variable(:@name, with_value: "Douglass")
  end

  it "is expected to pass other_keywords definition to child components" do
    expect(child).to have_instance_variable(:@options, with_value: {class: "mt-1"})
  end

  it "is expected to allow children components to override keywords" do
    expect(parent).to have_instance_variable(:@favorite_food, with_value: "Pizza")
    expect(child).to have_instance_variable(:@favorite_food, with_value: "Tacos")
  end

  it "is expected to allow children components to add keywords" do
    expect(child).to have_instance_variable(:@age, with_value: 7)
  end

  it "is expected to allow children components to remove keywords" do
    expect(parent).to have_instance_variable(:@retired)
    expect(child).not_to have_instance_variable(:@retired)
  end
end
