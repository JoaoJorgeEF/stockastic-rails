class Produto < ApplicationRecord
  has_many :user_produtos
  has_many :users, through: :user_produtos

  scope :by_user, ->(user_id) {
    joins(:user_produtos).where(user_produtos: { user_id: user_id})
  }

  def incrementar_quantidade(quantidade)
    return unless quantidade.is_a?(Integer)

    self.quantidade_atual += quantidade
  end

  def decrementar_quantidade(quantidade)
    return unless quantidade.is_a?(Integer)

    if quantidade_atual >= quantidade && (quantidade_atual - quantidade) >= quantidade_minima
      self.quantidade_atual -= quantidade
    end
  end
end
