class CreateCompromissos < ActiveRecord::Migration
  def change
    create_table :compromissos do |t|
      t.string :titulo
      t.text :descricao
      t.date :date

      t.timestamps null: false
    end
  end
end
