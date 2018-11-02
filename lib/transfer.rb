class Transfer
  attr_accessor :sender, :receiver, :amount, :status
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if @sender.valid? && @sender.balance >= @amount
      if @status == 'pending'
        @sender.balance -= @amount
        @receiver.balance += @amount
        @status = 'complete'
      end
    else
      @status = 'rejected'
      return "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == 'complete'
      @sender += @amount
      @receiver -= @amount
      @status = 'reversed'
    end
  end
end
