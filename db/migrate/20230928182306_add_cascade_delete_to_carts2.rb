class AddCascadeDeleteToCarts2 < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :cart_items, :items  # Supprimer la clé étrangère existante
    remove_foreign_key :cart_items, :carts  # Supprimer la clé étrangère entre cart_items et carts

    # Ajouter la clé étrangère avec suppression en cascade vers la table "carts"
    add_foreign_key :cart_items, :carts, on_delete: :cascade
  end
end
