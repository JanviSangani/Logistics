class Order < ApplicationRecord
  validate :external_id, :unique => true
  has_many :line_items
end
