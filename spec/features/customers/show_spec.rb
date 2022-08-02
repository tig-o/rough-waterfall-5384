require 'rails_helper'

RSpec.describe Customer, type: :feature do
    it 'displays a list of all customers items' do
        king_soopers = Supermarket.create(name: "King Soopers", location: "Denver, CO")

        bob = Customer.create(name: "Bob", supermarket_id: king_soopers.id)

        milk = Item.create(name: "Milk", price: 5)
        bread = Item.create(name: "Bread", price: 2)
        cookies = Item.create(name: "Cookies", price: 3)

        customer_item1 = CustomerItem.create(customer_id: bob.id, item_id: milk.id)
        customer_item2 = CustomerItem.create(customer_id: bob.id, item_id: bread.id)
        customer_item3 = CustomerItem.create(customer_id: bob.id, item_id: cookies.id)

        visit "customers/#{bob.id}"

        within "#list-of-items" do
            expect(page).to have_content("Milk")
            expect(page).to have_content("Bread")
            expect(page).to have_content("Cookies")
        end
    end

    it 'displays supermarket name which the items belong to' do
        king_soopers = Supermarket.create(name: "King Soopers", location: "Denver, CO")

        bob = Customer.create(name: "Bob", supermarket_id: king_soopers.id)

        milk = Item.create(name: "Milk", price: 5)
        bread = Item.create(name: "Bread", price: 2)
        cookies = Item.create(name: "Cookies", price: 3)

        customer_item1 = CustomerItem.create(customer_id: bob.id, item_id: milk.id)
        customer_item2 = CustomerItem.create(customer_id: bob.id, item_id: bread.id)
        customer_item3 = CustomerItem.create(customer_id: bob.id, item_id: cookies.id)

        visit "customers/#{bob.id}"

        within "#name-of-supermarket" do
            expect(page).to have_content("King Soopers")
        end
    end
end