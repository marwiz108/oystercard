class Oystercard

  TOPUP_LIMIT = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    #raise "Top up limit of #{TOPUP_LIMIT} reached" if @balance + amount > TOPUP_LIMIT
    if @balance + amount > TOPUP_LIMIT
      raise "Top up limit of #{TOPUP_LIMIT} reached"
    else
      @balance += amount
    end
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    !!@on
  end

  def touch_in
    @on = true
  end

  def touch_out
    @on = false
  end

end
