require 'rubygems'
require 'sinatra'
require 'haml'
require '../app/models/user'
require '../app/models/item'
require '../app/controllers/main'
require '../app/controllers/authentication'
require '../app/controllers/transaction'

class App < Sinatra::Base

  use Authentication
  use Main
  use Transaction

  enable :sessions
  set :public_folder, 'app/public'

  configure :development do
    Client::User.init('ese').save()
    Client::User.init('joel').save()
    Client::User.init('aron').save()

    a = Client::User.by_name('ese')
    a.add_item(Client::Item.init('Barrey', 10))
    a.item_by_name('Barry').activate
    a.add_item(Client::Item.init('Fifi', 200))

    b = Client::User.by_name('aron')
    b.add_item(Client::Item.init('Jim', 50))
    b.item_by_name('Jim').activate
    b.add_item(Client::Item.init('El Ron Hubbard', 50))

    c = Client::User.by_name('joel')
    c.add_item(Client::Item.init('Weasly', 30))
    c.item_by_name('Weasly').activate

   # University::Student.all.each do |student|
    #  student.add( rand(6-1) + 1 )
   # end
  end

end

# Now, run it
App.run!
