require "rails_helper"

RSpec.describe OtherKeywordsComponent, type: :component do
  it "renders component" do
    render_inline(described_class.new(name: "Example", class: "test"))

    expect(page).to have_css "div[data-instance-variable='@name']", text: "Example"
    expect(page).to have_css "div[data-instance-variable='@options']", text: "{:class=>\"test\"}"
  end
end
