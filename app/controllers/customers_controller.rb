class CustomersController < ApplicationController
    def show
        @customer = Customer.find(params[:id])
        @customer_items = @customer.items
        @supermarket = @customer.supermarket
    end
end