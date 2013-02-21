Orcharding::Repositories.configure do |conf|
  conf.register_bill_repository Orcharding::BillRepository
  conf.register_fruit_repository Orcharding::FruitRepository
end

#Orcharding::Seeder.load_from_json File.read("db/bill_seed_data.json")
Orcharding::Seeder.load_from_json File.read("db/seed_data.json")

