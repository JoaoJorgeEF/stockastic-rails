require 'rails_helper'

RSpec.describe Produto, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe '#incrementar_quantidade' do
    it 'incrementa corretamente' do
      produto = Produto.new(quantidade_atual: 5)
      produto.incrementar_quantidade(15)
      expect(produto.quantidade_atual).to eq(20)
    end

    it 'não incrementa se quantidade não for integer' do
      produto = Produto.new(quantidade_atual: 5)
      produto.incrementar_quantidade("15")
      expect(produto.quantidade_atual).to eq(5)
    end
  end

  describe '#decrementar_quantidade' do
    it 'decrementa corretamente' do
      produto = Produto.new(quantidade_atual: 15)
      produto.decrementar_quantidade(5)
      expect(produto.quantidade_atual).to eq(10)
    end

    it 'não decrementa se quantidade for maior do que quantidade_atual' do
      produto = Produto.new(quantidade_atual: 15)
      produto.decrementar_quantidade(20)
      expect(produto.quantidade_atual).to eq(15)
    end

    it 'não decrementa se resultado for menor do que quantidade_minima' do
      produto = Produto.new(quantidade_atual: 15, quantidade_minima: 8)
      produto.decrementar_quantidade(10)
      expect(produto.quantidade_atual).to eq(15)
    end

    it 'não decrementa se quantidade não for integer' do
      produto = Produto.new(quantidade_atual: 15)
      produto.decrementar_quantidade("5")
      expect(produto.quantidade_atual).to eq(15)
    end
  end
end
