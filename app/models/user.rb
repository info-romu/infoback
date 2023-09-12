class User < ApplicationRecord
	# Il faut ajouter les deux modules commençant par jwt
	devise :database_authenticatable, :registerable,
	:jwt_authenticatable,
	jwt_revocation_strategy: JwtDenylist

  

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
end