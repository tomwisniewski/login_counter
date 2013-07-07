require 'sinatra/base'
require 'sinatra/flash'
require 'debugger'
require_relative '../models/dmconfig'

class LoginCounter < Sinatra::Base

  register Sinatra::Flash

  configure do
    use Rack::Session::Cookie, :key => 'rack.session',
                               :secret => 'hello my name is sausage roll',
                               :http_only => true 

    set :root, Proc.new { File.join(File.dirname(__FILE__), "../../") }
  end

  helpers do
    def signed_in?
      session[:user]
    end
  end    

  get '/' do
    if signed_in?
      redirect '/counter'
    else  
      erb :index
    end  
  end

  post '/signup' do
    @new_user = User.new
    @new_user = User.build(params[:first_name],
                    params[:last_name],
                    params[:email],
                    params[:password],
                    params[:password_confirmation])
    if @new_user.save
      erb(:success, :layout => false)
    else
      erb(:failure, :layout => false)
    end    
  end  

  post '/login' do
    @user = User.first(:email => params[:login_email])
    if @user && @user.password == params[:login_password]
      @user.update_login_count(@user.login_count + 1)
      session[:user] = @user.first_name
      redirect '/counter'
    else
      flash[:signin_error] = "Your email and/or password is incorrect"
      redirect '/' 
    end   
  end 

  get '/counter' do
    if signed_in?
      @user = User.first(:first_name => session[:user])
      @count = @user.login_count
      erb :counter
    else
      erb :counter
    end    
  end  

  get '/signout' do
    session[:user] = nil
    flash[:goodbye] = "Goodbye!"
    redirect '/counter'
  end 
end  