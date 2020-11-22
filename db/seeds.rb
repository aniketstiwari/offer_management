require 'csv'

records = []
CSV.foreach(Rails.root.join('lib/seed_csv/users.csv'), headers: true, encoding:'utf-8') do |row|
  records << row.to_h.merge("created_at" => DateTime.now, "updated_at" =>  DateTime.now)
end
User.insert_all(records)

records = []
CSV.foreach(Rails.root.join('lib/seed_csv/offers.csv'), headers: true, encoding:'utf-8') do |row|
  records << row.to_h.merge("created_at" => DateTime.now, "updated_at" =>  DateTime.now)
end
Offer.insert_all(records)

records = []
CSV.foreach(Rails.root.join('lib/seed_csv/departments.csv'), headers: true, encoding:'utf-8') do |row|
  records << row.to_h.merge("created_at" => DateTime.now, "updated_at" =>  DateTime.now)
end
Department.insert_all(records)

records = []
CSV.foreach(Rails.root.join('lib/seed_csv/user_departments.csv'), headers: true, encoding:'utf-8') do |row|
  records << row.to_h.merge("created_at" => DateTime.now, "updated_at" =>  DateTime.now)
end
UserDepartment.insert_all(records)

records = []
CSV.foreach(Rails.root.join('lib/seed_csv/offer_departments.csv'), headers: true, encoding:'utf-8') do |row|
  records << row.to_h.merge("created_at" => DateTime.now, "updated_at" =>  DateTime.now)
end
OfferDepartment.insert_all(records)
