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
    if !User.all.find_by("username" => params[:username])
      user = User.create(params)
    else
      @failed_auth = true
      return erb :register
    end
    session[:user_id] = user.id
    redirect "/home"
  end

  get "/login" do
      @session = session
      session[:user_id] = 0
      erb :login
  end

  post "/login" do
    user = User.find_by(username: params[:username]).authenticate(params[:password])
    if user
      session[:user_id] = user.id
      redirect to '/home'
    else
      redirect to '/failure'
    end
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end

  get "/failure" do
    @failed_auth = true 
    erb :login
  end

  get "/home" do
    protected!
 
    @restaurants = Restaurant.all
    @friendships = Friendship.all
    @self = Helpers.user(session)
    @users = User.all
    erb :index
  end

  helpers do
    def protected!
      return if authorized?
      redirect '/login'
    end
  
    def authorized?
     true if !session[:user_id].nil? && session[:user_id] > 0
    end
  end

end