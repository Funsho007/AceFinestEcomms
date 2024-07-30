class Product < ApplicationRecord
  mount_uploader :image, ProductImageUploader
  belongs_to :product_category
  has_many :order_items

  validate :product_category_present
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  scope :recent_products, -> { where("products.updated_at >= ?", 3.days.ago) }
  scope :featured_products, -> { where(is_featured: true) }

  # validates :price, presence: true, format: { with: /\A\d+(?:\.\d{2})?\z/ }, numericality: { greater_than: 0, less_than: 1000000 }
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "name", "price", "product_category_id", "quantity", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["order_items", "product_category"]
  end
  private

  def product_category_present
    if product_category.nil?
      errors.add(:product_category, "is necessary.")
    end
  end
end
