# app/models/product.rb
class Product < ApplicationRecord
  # Mount uploader for handling product images
  mount_uploader :image, ProductImageUploader

  # Associations
  belongs_to :product_category
  has_many :order_items

  # Validations
  validate :product_category_present
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{2})?\z/ }, numericality: { greater_than_or_equal_to: 0.01, less_than_or_equal_to: 999999.99 }

  # Scopes
  scope :recent_products, -> { where("products.updated_at >= ?", 3.days.ago) }
  scope :featured_products, -> { where(is_featured: true) }

  # Ransack configuration
  def self.ransackable_attributes(auth_object = nil)
    super + ["created_at", "description", "id", "name", "price", "product_category_id", "quantity", "updated_at", "is_featured" ]
  end

  def self.ransackable_associations(auth_object = nil)
    super + ["order_items", "product_category"]
  end

  private

  # Custom validation to ensure product_category is present
  def product_category_present
    if product_category.nil?
      errors.add(:product_category, "is necessary.")
    end
  end
end
