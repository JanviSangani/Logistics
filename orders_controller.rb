class ApplicationController < ApplicationController
  def create
    begin
    #check for required params here.
    unless params[:external_id].present? && params[:placed_at].present? && params[:line_items].present?
      return {status: 801, success: false, message: "Required params are missing"}
    end

    already_exist = Order.find_by(external_id: params[:external_id])
    if already_exist
      if already_exist.locked_at.present? || already_exist.locked_at > Time.now - 15.minutes
        return {status: 801, success: false, message: "Locked for Edit"}
      end
    end

    order = Order.create!(external_id: params[:external_id], placed_at: DateTime.now)
    if order.persist
      params[:line_items]&.each do |line_item|
        order.line_items.create(sku: line_item[:sku], quantity: line_item[:quantity], original: true)
      end
    end
    return {status: 200, success: true, message: "Order Created"}

    rescue StandardError => e
      errors.add({status: 801, success: false, message: e.message})
    end
  end
end
