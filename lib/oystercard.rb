class Oystercard

  TOPUP_LIMIT = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Top up limit of #{TOPUP_LIMIT} reached" if @balance + amount > TOPUP_LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

end
