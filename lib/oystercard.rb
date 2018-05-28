class Oystercard

  TOPUP_LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :journeys, :entry_station, :exit_station

  def initialize
    @balance = 0
    @journeys = {}
  end

  def top_up(amount)
    raise "Top up limit of #{TOPUP_LIMIT} reached" if balance + amount > TOPUP_LIMIT
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    raise 'Insufficient balance' if balance < MINIMUM_FARE
    @entry_station = station
    journeys[:entry] = entry_station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @entry_station = nil
    @exit_station = station
    journeys[:exit] = exit_station
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
