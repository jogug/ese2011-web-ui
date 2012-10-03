require 'tilt/haml'
require '../app/models/user'

class Authentication < Sinatra::Application

  get "/login" do
    haml :login
  end

  post "/login" do
    name = params[:username]
    password = params[:password]

    if name.nil? or password.nil?
      redirect '/login'
    end


    student = Client::User.by_name name
    # Here, authentication succeeds if username==password
    # In a real application, we would of
    # course check the password differently.
    if student.nil? or password != name
      redirect '/login'
    end


    session[:name] = name
    redirect '/'
  end

  get "/logout" do
    session[:name] = nil
    redirect '/login'
  end

end
