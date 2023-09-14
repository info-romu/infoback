class User < ApplicationRecord
	# Il faut ajouter les deux modules commençant par jwt
  after_create :create_cart
	devise :database_authenticatable, :registerable,
	:jwt_authenticatable,
	jwt_revocation_strategy: JwtDenylist

  has_one :cart
  has_many :cart_items, through: :cart

  validates :email, presence: true 
  validates :password, presence: true
  validates :username, presence: true
  validate :password_complexity

  private

  def password_complexity
    unless password =~ /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[@#$%^&+=_-]).{8,}$/;
      errors.add(:password, "doit contenir au moins une majuscule, une minuscule et un chiffre")
    end
  end

  def create_cart
    Cart.create(user: self)
  end
end