require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  it("has an initial balance of 0") do
    expect(subject.balance).to eq(0)
  end

  it("adds money to the card") do
    subject.top_up(5)
    expect(subject.balance).to eq(5)
  end

end
