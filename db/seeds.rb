# db/seeds.rb

# Création d un seed qui va crées 5 items ,2 utilisateurs 1 avec is_admin null et 1 avec true, puis va ajouter 2 items dans le cart du premiers utilisateur 


# Supprimer tous les enregistrements existants
CartItem.destroy_all
User.destroy_all
Item.destroy_all

1.times do
  Item.create(
    name: "Chargeur portable voiture electrique T2",
    description: "Chargez votre voiture électrique n'importe où mais pas n'importe comment avec le chargeur portable Premium 10m 6A-16A type 2 compatible tous modèles",
    price: 499,
    imageUrl: "https://i.postimg.cc/0jP0b9B3/Chargeur-portable-voiture-electrique-monophase-37k-W-securecharge.webp"
  )
  Item.create(
    name: "Support mural pour câbles",
    description: "Support mural pour câbles & chargeurs de véhicules électriques & hybrides rechargeables - Type 2",
    price: 32,
    imageUrl: "https://i.postimg.cc/L64VS6fg/support-pour-cable-chargeurs-de-vehicules-electriques-et-hybrides-rechargeables.webp"
  )
  Item.create(
    name: "Adaptateur de chargeur",
    description: "Adaptateur de chargeur voiture Type 1 vers Type 2 | Chargeur VE",
    price: 99,
    imageUrl: "https://i.postimg.cc/RhdQtjr0/0001517-type-1-mobile-charger-16a.jpg"
  )
  Item.create(
    name: "Chargeur portable voiture electrique T3",
    description: "Câble de recharge type 3 - type 2, monophasé - 32A max",
    price: 254,
    imageUrl: "https://i.postimg.cc/sDn4gd96/CPC-Adaptateur-de-chargeur-voiture-Type-1-vers-Type-2-2.jpg"
  )
  Item.create(
    name: "Chargeur portable voiture electrique T1",
    description: "Ce chargeur mobile de 5,5 mètres chargera votre véhicule électrique avec prise type 1 a partir d'une prise industrielle CEE bleu monophasé de 16A",
    price: 192,
    imageUrl: "https://i.postimg.cc/ZYxLXy9h/cable-type-3.jpg"
  )
end

User.create(
    username: "Citron1",
    email: "Citron1@gmail.com",
    password: "Citron1-"
  )
  
  User.create(
    username: "Citron2",
    email: "Citron2@gmail.com",
    password: "Citron2-",
    is_admin: true
  )
  
  user = User.first
  CartItem.create(
    cart: user.cart,
    item: Item.first,
    quantity: 1
  )
  
  CartItem.create(
    cart: user.cart,
    item: Item.second,
    quantity: 2
  )

puts "Seed data generated successfully!"