class OfferPresenter
  attr_accessor :user_id, :per_page, :sort, :query, :departments, :user, :user_company, :user_departments, :offer_records

  def initialize(params)
    self.user_id          = params[:user_id]
    self.per_page         = params[:page] || 30
    self.sort             = params[:sort] || :asc
    self.query            = params[:query] || ""
    self.departments      = JSON.parse(params[:departments]) rescue []
    self.user             = User.find_by_id(user_id)
    self.user_company     = user.company
    self.user_departments = user.departments.pluck(:name)
    self.offer_records    = Offer.fetch_offer_by_company(user_company)
  end

  def format_offer_list
    offers_list = []
    perfect_match    = perfect_offers
    good_match       = good_offer
    api_suggestion   = suggestion_by_api(fetch_records = 5)
    recommend_list   = get_offer_list(fetch_records = 30)
    offers_list << perfect_match << good_match
    (offers_list + api_suggestion + recommend_list).uniq{|d| [d[:company], d[:price]]}
  end

  def perfect_offers
    Offer.perfect_match_offers(user_departments, offer_records, departments, query)
  end

  def good_offer
    Offer.good_match_offers(offer_records, departments, query)
  end

  def suggestion_by_api(fetch_records)
    OfferRecommendation.new.suggested_by_api(fetch_records)
  end

  def get_offer_list(fetch_records)
    Offer.recommended_offers(fetch_records, departments, query)
  end

end