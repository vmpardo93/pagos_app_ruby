class TransactionRepositoryAR
  def save(transaction)
    record = TransactionRecord.find_or_initialize_by(
      transaction_number: transaction.transaction_number
    )

    record.status = transaction.status
    record.amount = transaction.amount
    record.product_id = transaction.product_id
    record.quantity = transaction.quantity
    record.payment_reference = transaction.payment_reference
    record.payment_provider = 'WOMPI'

    record.save!
    transaction
  end
end