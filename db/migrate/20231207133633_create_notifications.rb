class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.text :mensagem
      t.text :atribuicao
      t.references :produto, null: false, foreign_key: true

      t.timestamps
    end
  end
end
