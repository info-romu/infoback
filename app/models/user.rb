class User < ApplicationRecord
	before_validation :create_on_stripe, on: :create
  after_create :create_cart
	devise :database_authenticatable, :registerable,
	:jwt_authenticatable,
	jwt_revocation_strategy: JwtDenylist

  has_one :cart
  has_many :cart_items, through: :cart

  validates :stripe_id, presence: true
  validates :email, presence: true 
  validates :password, presence: true
  validates :username, presence: true
  validate :password_complexity



  private

  def create_on_stripe
    params = { email: email, name: username } 
    response = Stripe::Customer.create(params)
    self.stripe_id = response.id
  end
  

  def password_complexity
    unless password =~ /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[@#$%^&+=_-]).{8,}$/;
      errors.add(:password, "doit contenir au moins une majuscule, une minuscule et un chiffre")
    end
  end

  def create_cart
    Cart.create(user: self)
  end
end