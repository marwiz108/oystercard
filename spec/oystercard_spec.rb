require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  it("has an initial balance of 0") do
    expect(subject.balance).to eq(0)
  end

  describe("card balance") do
    before(:each) do
      subject.top_up(Oystercard::TOPUP_LIMIT)
    end

    it("adds money to the card") do
      expect(subject.balance).to eq(90)
    end

    it("throws error message if balance exceeds limit") do
      expect { subject.top_up(5) }.to raise_error("Top up limit of #{Oystercard::TOPUP_LIMIT} reached")
    end
  end

  describe("journey") do
    before(:each) do
      subject.top_up(Oystercard::TOPUP_LIMIT)
    end

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

    it("deducts balance at the end of the journey") do
      subject.touch_in
      expect { subject.touch_out }.to change{subject.balance}.by(-Oystercard::MINIMUM_FARE)
    end
  end

  it("does not touch in if balance is below minimum") do
    expect { subject.touch_in }.to raise_error("Insufficient balance")
  end
end
