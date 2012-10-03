require 'haml'
require '../app/models/user'

class Main < Sinatra::Application

  get "/" do

    redirect '/login' unless session[:name]

    haml :list_users, :locals => { :time => Time.now ,
                                      :users => Client::User.all,
                                      :current_name => session[:name] }
  end

end
