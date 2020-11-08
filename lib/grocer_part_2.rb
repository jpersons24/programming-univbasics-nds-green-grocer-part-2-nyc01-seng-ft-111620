require_relative './part_1_solution.rb'

# takes a hash and applies coupons
# return: a new array
# coupon structure: []{:item => "AVACADO", :num => 2, :cost => 5.00}]

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  counter = 0
  while counter < coupons.length

    # check for specific item within the cart
    cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    coupon_item_name = "#{coupons[counter][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(coupon_item_name, cart)

    if cart_item && cart_item[:count] >= coupons[counter][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[counter][:num]
        cart_item[:count] -= coupons[counter][:num]
      else
        cart_item_with_coupon = {
          :item => coupon_item_name,
          :price => coupons[counter][:cost] / coupons[counter][:num],
          :count => coupons[counter][:num],
          :clearance => cart_item[:clearance]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[counter][:num]
      end
    end
    counter += 1
  end
  cart
end

# takes a hash and applies discounts for clearance items
# return:

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  counter = 0
  while counter < cart.length
      if cart[counter][:clearance]
        cart[counter][:price] = (cart[counter][:price] - (cart[counter][:price] * 0.20)).round(2)
      end
    counter += 1
  end
  cart
end

# takes unconsolidated cart, consolidates it, applys coupons, and applys clearance
# runs consolidated_cart, apply_coupons and apply_clearance
# totals sum of all items and applys 'total price' discount if available
# return: final cost


def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers

  consolidate_cart(cart)
  # consolidated_cart = consolidate_cart(cart)

  consolidated_cart_with_coupons = apply_coupons(consolidate_cart, coupons)

  consolidated_and_discounts_applied = apply_clearance(consolidated_cart_with_coupons)

  consolidated_and_discounts_applied.each do |grocery_item|
    grand_total = grocery_item[:price] * grocery_item[:count]
    grand_total
  end

  if grand_total >= 100
    final_total = grand_total * 0.10
    final_total
  else
    grand_total
  end

end
