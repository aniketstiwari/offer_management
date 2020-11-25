require 'httparty'

class OfferRecommendation
  def initialize
    begin
      @offers = HTTParty.get('https://bravado.co/api/api/opportunity/intros.json')
    rescue => e
      puts "Error fetching the api"
      puts "#{e.message}"
    end
  end

  def suggested_by_api(fetch_records)
    offer_list = []
    @offers["intros"].each do |offer|
      h = {}
      h[:id] = offer["request_company"]["id"]
      h[:company] = offer["request_company"]["name"]
      h[:price] = offer["price"]
      h[:label] = "from_api"
      offer_list.push(h)
    end
    offer_list.first(fetch_records)
  end

end