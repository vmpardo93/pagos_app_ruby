class Transaction
  attr_reader :id, :transaction_number, :status, :amount,
              :product_id, :quantity, :payment_reference

  PENDING = 'PENDING'
  SUCCESS = 'SUCCESS'
  FAILED  = 'FAILED'

  def initialize(id: nil, transaction_number:, amount:, product_id:, quantity:, status: PENDING, payment_reference: nil)
    @id = id
    @transaction_number = transaction_number
    @amount = amount
    @product_id = product_id
    @quantity = quantity
    @status = status
    @payment_reference = payment_reference
  end

  def mark_success!(reference)
    @status = SUCCESS
    @payment_reference = reference
  end

  def mark_failed!
    @status = FAILED
  end
end
