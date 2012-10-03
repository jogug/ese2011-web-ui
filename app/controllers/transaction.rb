require 'haml'
require '../app/models/user'
require '../app/models/item'

class Transaction < Sinatra::Application

  post "/buy" do
    item_name = params[:item_fetch]
    seller_name = params[:seller_fetch]
    buyer_name = params[:buyer_fetch]

    fail "Empty username or password" if item_name.nil? or seller_name.nil? or buyer_name.nil?

    buyer =  Client::User.by_name buyer_name
    seller = Client::User.by_name seller_name
    buyer.buy_item(seller, seller.item_by_name(item_name))


    redirect '/'
  end

  put "/sell" do
    item_name = params[:item_fetch]
    seller_name = params[:seller_fetch]

    fail "Empty username or password" if item_name.nil? or seller_name.nil?


    seller = Client::User.by_name seller_name
    seller.item_by_name(item_name).activate


    redirect '/'
  end

end