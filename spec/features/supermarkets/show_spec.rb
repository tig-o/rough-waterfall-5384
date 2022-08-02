require 'rails_helper'

RSpec.describe Supermarket, type: :feature do
    it 'displays name of supermarket' do
        king_soopers = Supermarket.create(name: "King Soopers", location: "Denver, CO")

        bob = Customer.create(name: "Bob", supermarket_id: king_soopers.id)

        milk = Item.create(name: "Milk", price: 5)
        bread = Item.create(name: "Bread", price: 2)
        cookies = Item.create(name: "Cookies", price: 3)

        customer_item1 = CustomerItem.create(customer_id: bob.id, item_id: milk.id)
        customer_item2 = CustomerItem.create(customer_id: bob.id, item_id: bread.id)
        customer_item3 = CustomerItem.create(customer_id: bob.id, item_id: cookies.id)

        visit "supermarkets/#{king_soopers.id}"

        within "#supermarket-name" do
            expect(page).to have_content("King Soopers")
        end
    end

    it 'displays link that goes to supermarkets item index page' do
        king_soopers = Supermarket.create(name: "King Soopers", location: "Denver, CO")

        bob = Customer.create(name: "Bob", supermarket_id: king_soopers.id)
        milk = Item.create(name: "Milk", price: 5)
        bread = Item.create(name: "Bread", price: 2)
        cookies = Item.create(name: "Cookies", price: 3)

        customer_item1 = CustomerItem.create(customer_id: bob.id, item_id: milk.id)
        customer_item2 = CustomerItem.create(customer_id: bob.id, item_id: bread.id)
        customer_item3 = CustomerItem.create(customer_id: bob.id, item_id: cookies.id)

        denji = Customer.create(name: "Denji", supermarket_id: king_soopers.id)
        soup = Item.create(name: "Soup", price: 3)
        cheese = Item.create(name: "Cheese", price: 2)

        customer_item4 = CustomerItem.create(customer_id: denji.id, item_id: soup.id)
        customer_item5 = CustomerItem.create(customer_id: denji.id, item_id: cheese.id)
        customer_item6 = CustomerItem.create(customer_id: denji.id, item_id: cookies.id)

        visit "supermarkets/#{king_soopers.id}"

        within "#view-items-link" do
            expect(page).to have_link("View All Items")
            click_link('View All Items')
        end

        within "#unique-items-list" do
            expect(page).to have_content("Milk")
            expect(page).to have_content("Bread")
            expect(page).to have_content(cookies.name).once
            expect(page).to have_content("Soup")
            expect(page).to have_content("Cheese")
        end
    end
end