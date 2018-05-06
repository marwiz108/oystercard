require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  it("has an initial balance of 0") do
    expect(subject.balance).to eq(0)
  end
end
