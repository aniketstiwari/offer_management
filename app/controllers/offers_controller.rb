class OffersController < ApplicationController

  def get_best_deals
    render json: { 
      success: true, 
      data: OfferPresenter.new(params).format_offer_list
    }
  end

end