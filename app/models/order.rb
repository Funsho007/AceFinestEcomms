class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  enum status: { new: 0, paid: 1, shipped: 2, cancelled: 3 }, _prefix: :type
  enum payment_method: { cash_on_delivery: 0, online_payment: 1 }

  attr_accessor :city, :province

  TAX_RATE = 0.1 # 10% tax rate

  validates :user, presence: true, if: :user_required?
  validate :user_present

  def total_with_tax
    total = order_items.sum('quantity * price')
    total_with_tax = total * (1 + TAX_RATE)
    total_with_tax
  end

  private

  def user_present
    if user_id.nil?
      errors.add(:user, "is necessary.")
    end
  end

  def user_required?
    !user_id.nil?
  end

  def self.ransackable_attributes(auth_object = nil)
    ["address", "city", "created_at", "delivery_charges", "id", "payment_method", "status", "total", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["order_items", "user"]
  end
end
