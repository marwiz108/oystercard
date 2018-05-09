require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  it("has an initial balance of 0") do
    expect(subject.balance).to eq(0)
  end

  describe("card balance") do
    it("adds money to the card") do
      subject.top_up(5)
      expect(subject.balance).to eq(5)
    end

    it("throws error message if balance exceeds limit") do
      topup_limit = Oystercard::TOPUP_LIMIT
      subject.top_up(topup_limit)
      expect { subject.top_up(5) }.to raise_error("Top up limit of #{topup_limit} reached")
    end

    it("deducts balance of the card") do
      subject.top_up(50)
      subject.deduct(5)
      expect(subject.balance).to eq(45)
    end
  end

  describe("journey") do
    it("starts not in journey") do
      expect(subject).not_to be_in_journey
    end

    it("allows user to touch in") do
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it("allows user to touch out") do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end
end
