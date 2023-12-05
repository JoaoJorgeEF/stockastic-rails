class Produto < ApplicationRecord

  has_many :user_produtos
  has_manby :users, through: :user_produtos

  def incrementar_quantidade(quantidade)
    return unless quantidade.is_a?(Integer)

    quantidade_atual += quantidade
  end

  def decrementar_quantidade(quantidade)
    return unless quantidade.is_a?(Integer)

    if quantidade_atual >= quantidade && (quantidade_atual + quantidade >= quantidade_minima)
      quantidade_atual  -= quantidade
    end
  end
end
