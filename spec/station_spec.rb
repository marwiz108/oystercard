require 'station'

describe Station do
  subject(:station) { described_class.new(name, zone) }
  let(:name) { "Aldgate East" }
  let(:zone) { 1 }

  it 'has a name' do
    expect(subject.name).to eq("Aldgate East")
  end

  it 'has a zone' do
    expect(subject.zone).to eq(1)
  end
end
