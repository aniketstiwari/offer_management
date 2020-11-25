class Offer < ApplicationRecord
  has_many :offer_departments
  has_many :departments, through: :offer_departments

  class << self
    def perfect_match_offers(user_departments, offers, departments, query)
      scope = Offer
      scope = scope.joins(offer_departments: [department: :users]).where('offer_departments.offer_id IN (?)', offers.pluck(:id))
      scope = scope.where("user_departments.department_id": departments) if departments.present?
      scope = scope.where("offers.company like ?", "%#{query}%") if query.present?
      offer_deparments = scope.select("departments.name, offers.id as offer_id, offers.price as price, offers.company as company").map{|d| d.attributes.except("id")}.uniq
      offer_deparments.select{|d| user_departments.include?(d["name"])}.map{|d| { id: d["offer_id"], price: d["price"], company: d["company"], label: "perfect_match" }}.first
    end

    def good_match_offers(offers, departments, query)
      scope = offers.joins(departments: :users)
      scope = scope.where("user_departments.department_id": departments) if departments.present?
      scope = scope.where("offers.company like ?", "%#{query}%") if query.present?
      scope.map{ |offer| { id: offer.id, price: offer.price, company: offer.company, label: "good_match" } }.first
    end

    def recommended_offers(fetch_records, departments, query)
      scope = self.joins(departments: :users)
      scope = scope.where("user_departments.department_id": departments) if departments.present?
      scope = scope.where("offers.company like ?", "%#{query}%") if query.present?
      scope.order('price asc').map{|offer| { id: offer.id, price: offer.price, company: offer.company, label: "offer" }}.first(fetch_records)
    end

    def fetch_offer_by_company(user_company = nil)
      where(company: user_company)
    end
  end

end
