require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:station) { double :station }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { {entry: entry_station, exit: exit_station} }

  it 'has an initial balance of 0' do
    expect(subject.balance).to eq(0)
  end

  describe 'card balance' do
    before(:each) do
      subject.top_up(Oystercard::TOPUP_LIMIT)
    end

    it 'adds money to the card' do
      expect(subject.balance).to eq(90)
    end

    it 'throws error message if balance exceeds limit' do
      expect { subject.top_up(5) }.to raise_error("Top up limit of #{Oystercard::TOPUP_LIMIT} reached")
    end
  end

  describe 'journey' do
    before(:each) do
      subject.top_up(Oystercard::TOPUP_LIMIT)
    end

    describe '.in_journey?' do
      it 'starts not in journey' do
        expect(subject).not_to be_in_journey
      end

      it 'allows user to touch in' do
        subject.touch_in(station)
        expect(subject).to be_in_journey
      end

      it 'allows user to touch out' do
        subject.touch_in(station)
        subject.touch_out(exit_station)
        expect(subject).not_to be_in_journey
      end
    end

    describe '.touch_in' do
      it 'stores entry station at touch in' do
        subject.touch_in(station)
        expect(subject.entry_station).to eq(station)
      end

      it 'does not touch in if balance is below minimum' do
        allow(subject).to receive(:balance) {0}
        expect { subject.touch_in(station) }.to raise_error("Insufficient balance")
      end
    end

    describe '.touch_out' do
      it 'stores exit station' do
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject.exit_station).to eq(exit_station)
      end

      it 'deducts balance at the end of the journey' do
        subject.touch_in(station)
        expect { subject.touch_out(exit_station) }.to change{subject.balance}.by(-Oystercard::MINIMUM_FARE)
      end
    end

    it 'has an empty list of journeys by default' do
      expect(subject.journeys).to be_empty
    end

    it 'stores a journey' do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to include journey
    end
  end
end
