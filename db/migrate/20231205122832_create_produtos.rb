class CreateProdutos < ActiveRecord::Migration[7.1]
  def change
    create_table :produtos do |t|
      t.string :nome
      t.datetime :validade
      t.string :descricao
      t.decimal :preco_unitario
      t.integer :quantidade_minima
      t.integer :quantitade_atual

      t.timestamps
    end
  end
end
