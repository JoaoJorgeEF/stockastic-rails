class Produto < ApplicationRecord
  has_many :user_produtos
  has_many :users, through: :user_produtos
  has_many :notifications

  after_find do |produto|
    if produto.validade.present? && produto.validade < DateTime.now
      produto.notifications << Notification.new(
        mensagem: "Produto #{produto.nome} venceu em #{produto.validade.strftime('%d/%m/%Y')}!"
      )
      produto.save
    end
  end

  scope :by_user, ->(user_id) {
    joins(:user_produtos).where(user_produtos: { user_id: user_id})
  }

  def incrementar_quantidade(quantidade)
    return unless quantidade.is_a?(Integer)

    self.quantidade_atual += quantidade
    notifications << Notification.new(
      mensagem: "#{nome} incrementou de #{quantidade_atual-quantidade} para #{quantidade_atual}"
    )
  end

  def decrementar_quantidade(quantidade)
    return unless quantidade.is_a?(Integer)

    if quantidade_atual >= quantidade && (quantidade_atual - quantidade) >= quantidade_minima
      self.quantidade_atual -= quantidade
      notifications << Notification.new(
        mensagem: "#{nome} decrementou de #{quantidade_atual+quantidade} para #{quantidade_atual}"
      )
    end
  end
end
