class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :user_roles
  belongs_to :province

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :postal_code, presence: true
  validates :province_id, presence: true
  validates :phone_number, presence: true

  after_create :assign_default_role

  # Add stripe_customer_id attribute
  attribute :stripe_customer_id, :string

  def self.ransackable_attributes(auth_object = nil)
    super + %w[full_name address city postal_code]
  end

  def assign_default_role
    self.add_role(:customer) if self.roles.blank?
  end

end
