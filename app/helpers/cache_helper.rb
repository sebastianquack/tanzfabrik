module CacheHelper
  def cache_key_for_kursplan types
    #count          = Product.count
    #max_updated_at = Product.maximum(:updated_at).try(:utc).try(:to_s, :number)
    #{}"products/all-#{count}-#{max_updated_at}"
    "x"
  end
end