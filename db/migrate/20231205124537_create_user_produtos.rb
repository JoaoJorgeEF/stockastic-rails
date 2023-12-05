class CreateUserProdutos < ActiveRecord::Migration[7.1]
  def change
    create_table :user_produtos do |t|
      t.references :user, null: false, foreign_key: true
      t.references :produto, null: false, foreign_key: true

      t.timestamps
    end
  end
end
