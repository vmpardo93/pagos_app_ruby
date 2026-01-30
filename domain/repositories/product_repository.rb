class ProductRepositoryAR
  def find(id)
    ProductRecord.find_by(id: id)
  end
end

