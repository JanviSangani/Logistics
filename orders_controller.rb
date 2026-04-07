class ApplicationController < ApplicationController
  def create
    begin
    #check for required params here.
    unless params[:external_id].present? && params[:placed_at].present? && params[:line_items].present?
      {status: 801, success: false, message: "Required params are missing"}
    end

    order = Order.create!(external_id: params[:external_id], placed_at: DateTime.now)
    if order.persist

    end
    rescue StandardError => e
      errors.add({status: 801, success: false, message: e.message})
    end
  end
end
