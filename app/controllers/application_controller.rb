require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "mS@IMD@<2)D<M!@)I1Q(U!@9"
  end

  not_found do
    status 404
    erb :failure
  end
  
  get "/" do
    redirect '/home'
  end

  get '/register' do
    erb :register
  end

  post "/register" do
    session[:user_id] = 0
    user = User.create(params)
    session[:user_id] = user.id
    redirect "/home"
  end

  get "/login" do
      @session = session
      session[:user_id] = 0
      erb :login
  end

  post "/login" do
    binding.pry
    user = User.find_by(username: params[:username]).authenticate(params[:password])
    if user
      session[:user_id] = user.id
      redirect to '/home'
    else
      redirect to '/failure'
    end
  end

  get "/logout" do
    session[:user_id] == 0
    redirect "/login"
  end

  get "/failure" do
    @failed_auth = true 
    erb :login
  end

  get "/home" do
    if Helpers.is_logged_in?(session)
      @users = User.all
      erb :home
    else
      redirect '/login'
    end
  end



end
