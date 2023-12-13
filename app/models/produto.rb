class Produto < ApplicationRecord
  include AASM
  
  # ASSOCIATIONS
  has_many :user_produtos
  has_many :users, through: :user_produtos
  has_many :notifications
  belongs_to :category, optional: true

  # VALIDATIONS
  validates :nome, presence: true
  validates :descricao, presence: true
  validates :preco_unitario, presence: true
  validates :validade, presence: true
  validates :quantidade_minima, presence: true
  validates :quantidade_atual, presence: true

  # CALLBACKS
  after_find do |produto|
    if (produto.disponivel? || produto.baixa_quantidade?) && produto.validade < DateTime.now
      produto.tornar_vencido
      produto.save
    end
  end

  # SCOPES
  scope :by_user, ->(user_id) {
    joins(:user_produtos).where(user_produtos: { user_id: user_id})
  }

  # STATUS
  aasm column: 'status' do
    state :desconhecido, initial: true
    state :disponivel
    state :zerado
    state :baixa_quantidade
    state :vencido

    event :tornar_desconhecido do
      transitions to: :desconhecido
    end

    event :tornar_disponivel do
      transitions to: :disponivel  
    end

    event :tornar_vencido do
      transitions from: %i[disponivel baixa_quantidade], to: :vencido, after: :notificar_vencimento
    end

    event :tornar_baixa_quantidade do
      transitions to: :baixa_quantidade, after: :notificar_baixa_quantidade
    end

    event :zerar do
      transitions from: :baixa_quantidade, to: :zerado, after: :notificar_zero_estoque
    end
  end

  # METHODS
  def incrementar_quantidade(quantidade)
    return unless quantidade.is_a?(Integer)

    self.quantidade_atual += quantidade

    if (zerado? || baixa_quantidade?) && quantidade_atual > self.quantidade_minima
      tornar_disponivel
    end
    notificar("#{nome} incrementou de #{quantidade_atual-quantidade} para #{quantidade_atual}")
  end

  def decrementar_quantidade(quantidade)
    return unless quantidade.is_a?(Integer)

    if quantidade_atual >= quantidade
      self.quantidade_atual -= quantidade
      notificar("#{nome} decrementou de #{quantidade_atual+quantidade} para #{quantidade_atual}")

      if quantidade_atual <= quantidade_minima && quantidade_atual > 0
        tornar_baixa_quantidade
      elsif quantidade_atual == 0
        zerar
      end
    end
  end

  def notificar_vencimento
    notificar("Produto #{self.nome} venceu em #{self.validade.strftime('%d/%m/%Y às %H:%M:%S')}!")
  end

  def notificar_baixa_quantidade
    notificar("Produto #{self.nome} registrou estoque baixo em #{DateTime.now.strftime('%d/%m/%Y às %H:%M:%S')}!")
  end

  def notificar_zero_estoque
    notificar("Produto #{self.nome} registrou estoque zerado em #{DateTime.now.strftime('%d/%m/%Y às %H:%M:%S')}!")
  end

  def notificar(mensagem)
    notifications << Notification.new(
      mensagem: mensagem
    )
  end
end
