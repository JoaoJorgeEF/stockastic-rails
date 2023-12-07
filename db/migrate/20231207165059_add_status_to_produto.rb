class AddStatusToProduto < ActiveRecord::Migration[7.1]
  def change
    add_column :produtos, :status, :string, default: "desconhecido"
  end
end
