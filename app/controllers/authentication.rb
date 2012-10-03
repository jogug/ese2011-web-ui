require 'tilt/haml'
require '../app/models/user'

class Authentication < Sinatra::Application

  get "/login" do
    haml :login
  end

  post "/login" do
    name = params[:username]
    password = params[:password]

    fail "Empty username or password" if name.nil? or password.nil?

    student = Client::User.by_name name
    # Here, authentication succeeds if username==password
    # In a real application, we would of
    # course check the password differently.
    fail "Username or password are not valid" if student.nil? or password != name

    session[:name] = name
    redirect '/'
  end

  get "/logout" do
    session[:name] = nil
    redirect '/login'
  end

end
