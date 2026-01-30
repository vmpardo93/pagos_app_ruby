class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.string  :transaction_number, null: false
      t.string  :status,             null: false
      t.decimal :amount,             precision: 10, scale: 2, null: false
      t.integer :product_id,         null: false
      t.integer :quantity,           null: false
      t.string  :payment_provider
      t.string  :payment_reference

      t.timestamps
    end

    add_index :transactions, :transaction_number, unique: true
  end
end
