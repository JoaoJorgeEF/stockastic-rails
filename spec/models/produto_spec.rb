require 'rails_helper'

RSpec.describe Produto, type: :model do
  let(:produto_full) {
    Produto.new(
      nome: FFaker::Name.unique.name,
      descricao: FFaker::LoremBR.paragraph,
      validade: DateTime.now,
      quantidade_minima: 2,
      quantidade_atual: 5,
      created_at: DateTime.now,
      updated_at: DateTime.now,
      status: "desconhecido"
    )
  }

  describe 'Transições de estados do AASM' do
    it 'começa com o estado inicial desconhecido' do
      expect(produto_full.status).to eq("desconhecido")
    end

    it 'transita para o estado disponivel' do
      produto_full.tornar_disponivel
      expect(produto_full.status).to eq("disponivel")
    end

    it 'transita para o estado baixa_quantidade' do
      produto_full.tornar_baixa_quantidade
      expect(produto_full.status).to eq("baixa_quantidade")
    end

    it 'transita de disponivel para o estado vencido' do
      produto_full.tornar_disponivel
      produto_full.update(validade: DateTime.now - 1.day)
      produto_full.tornar_vencido
      expect(produto_full.status).to eq("vencido")
    end

    it 'transita de baixa_quantidade para o estado zerado' do
      produto_full.tornar_baixa_quantidade
      produto_full.zerar
      expect(produto_full.status).to eq("zerado")
    end
  end

  describe 'Eventos do AASM' do
    it 'dispara o evento tornar_disponivel' do
      expect { produto_full.tornar_disponivel }.to change { produto_full.disponivel? }.from(false).to(true)
    end

    it 'dispara o evento tornar_baixa_quantidade' do
      expect { produto_full.tornar_baixa_quantidade }.to change { produto_full.baixa_quantidade? }.from(false).to(true)
    end

    it 'dispara o evento tornar_vencido' do
      produto_full.update(validade: DateTime.now - 1.day)
      produto_full.tornar_disponivel
      expect { produto_full.tornar_vencido }.to change { produto_full.vencido? }.from(false).to(true)
    end

    it 'dispara o evento zerar' do
      produto_full.tornar_baixa_quantidade
      expect { produto_full.zerar }.to change { produto_full.zerado? }.from(false).to(true)
    end
  end


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

    it 'não decrementa se quantidade não for integer' do
      produto = Produto.new(quantidade_atual: 15)
      produto.decrementar_quantidade("5")
      expect(produto.quantidade_atual).to eq(15)
    end
  end
end
