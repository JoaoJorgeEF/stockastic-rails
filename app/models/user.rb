class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  has_many :user_produtos
  has_many :produtos, through: :user_produtos

  VALID_TYPES = ['funcionario', 'empresa', 'admin']

  validates :tipo, inclusion: { in: VALID_TYPES }

  def admin?
    tipo == "admin"
  end

  def empresa?
    tipo == "empresa"
  end

  def funcionario?
    tipo == "funcionario"
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
end
