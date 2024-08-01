class Product < ApplicationRecord
  # Mount uploader for handling product images
  mount_uploader :image, ProductImageUploader

  # Associations
  belongs_to :product_category
  has_many :order_items

  # Validations
  validate :product_category_present
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :price, presence: true,
                  format: { with: /\A\d+(?:\.\d+)?\z/ },
                  numericality: { greater_than: 0, less_than: 1000000 }

  # Scopes
  scope :recent_products, -> { where("products.updated_at >= ?", 3.days.ago) }
  scope :featured_products, -> { where(is_featured: true) }

  # Ransack configuration
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "name", "price", "product_category_id", "quantity", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["order_items", "product_category"]
  end

  private

  # Custom validation to ensure product_category is present
  def product_category_present
    if product_category.nil?
      errors.add(:product_category, "is necessary.")
    end
  end
end
