class Supermarket < ApplicationRecord
  has_many :customers

  def all_items
    customers.joins(:items).select('items.*')
  end
end