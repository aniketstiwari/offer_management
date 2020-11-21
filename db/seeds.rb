require 'csv'

records = []
CSV.foreach(Rails.root.join('lib/seed_csv/users.csv'), headers: true, encoding:'utf-8') do |row|
  records << row.to_h.merge("created_at" => DateTime.now, "updated_at" =>  DateTime.now)
end
user_records = User.insert_all(records)

records = []
CSV.foreach(Rails.root.join('lib/seed_csv/offers.csv'), headers: true, encoding:'utf-8') do |row|
  records << row.to_h.merge("created_at" => DateTime.now, "updated_at" =>  DateTime.now)
end
offer_records = Offer.insert_all(records)

records = []
CSV.foreach(Rails.root.join('lib/seed_csv/departments.csv'), headers: true, encoding:'utf-8') do |row|
  records << row.to_h.merge("created_at" => DateTime.now, "updated_at" =>  DateTime.now)
end
department_records = Department.insert_all(records)

records = []
CSV.foreach(Rails.root.join('lib/seed_csv/user_departments.csv'), headers: true, encoding:'utf-8') do |row|
  records << row.to_h.merge("created_at" => DateTime.now, "updated_at" =>  DateTime.now)
end
user_department_records = UserDepartment.insert_all(records)

records = []
CSV.foreach(Rails.root.join('lib/seed_csv/offer_departments.csv'), headers: true, encoding:'utf-8') do |row|
  records << row.to_h.merge("created_at" => DateTime.now, "updated_at" =>  DateTime.now)
end
offer_department_records = OfferDepartment.insert_all(records)
