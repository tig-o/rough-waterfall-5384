require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customer_items }
    it { should have_many(:items).through(:customer_items) }
  end

  describe 'model methods' do
    describe '#total_price' do
      it 'sums price of all customers items' do
        king_soopers = Supermarket.create(name: "King Soopers", location: "Denver, CO")

        bob = Customer.create(name: "Bob", supermarket_id: king_soopers.id)

        milk = Item.create(name: "Milk", price: 5)
        bread = Item.create(name: "Bread", price: 2)
        cookies = Item.create(name: "Cookies", price: 3)

        customer_item1 = CustomerItem.create(customer_id: bob.id, item_id: milk.id)
        customer_item2 = CustomerItem.create(customer_id: bob.id, item_id: bread.id)
        customer_item3 = CustomerItem.create(customer_id: bob.id, item_id: cookies.id)
        
        expect(bob.total_price).to eq(10)
      end
    end
  end
end