class NegativeBalance < StandardError; end

class User < ApplicationRecord
  has_many :transactions

  def balance
    transactions.sum(:amount)
  end

  def transfer(recipient: nil, amount: 0)
    return if amount.zero?
    return unless recipient

    ActiveRecord::Base.transaction do
      transactions.create(description: "Transaction to #{recipient.name}", amount: -amount)
      raise NegativeBalance, "Cannot transfer (balance negative)" if balance.negative?
      recipient.transactions.create(description: "Received from #{recipient.name}", amount: amount)
    end
  end
end
