class UsersController < ApplicationController
  
  def autheticateUser
    
    msg = nil
    
    if params[:email] == "" or params[:email] == nil or params[:password] == "" or params[:password] == nil
      redirect_to :controller => "app", :action => "index"
      flash[:notice] = "all fields must be completed!"
      flash[:color]= "invalid"
      return        
    end
    msg = User.getAuthentication(params)
    if msg == "valid"  
      redirect_to :home
      return
    else
      redirect_to :controller => "app", :action => "index"
      return
    end 
  end
  
  def home
    @downloads = ['test']
    @tabactive = "dashboard"
    @previousactions = []
  end
  
  def logout
    session[:user] = nil
    redirect_to :controller => "app", :action => "index"
    return  
  end
  
end
