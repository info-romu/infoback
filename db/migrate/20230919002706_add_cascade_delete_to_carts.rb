class AddCascadeDeleteToCarts < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :carts, :users  # Supprimez d'abord la contrainte de clé étrangère existante, si elle existe
    
    add_foreign_key :carts, :users, on_delete: :cascade  # Ajoutez la nouvelle contrainte de suppression en cascade
  end
end
