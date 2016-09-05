class ApplicationController < ActionController::Base
  protect_from_forgery
  protected
  
  #This method is for preventing users to access confidential pages withuot logging in 
  def authenticate_user
    if session[:user]
      return true
    else
      redirect_to :controller => 'app', :action => 'messageUserLogin', :token => "login"
      return
    end
  end

  #This method is for preventing normal users to access admin pages
  def authenticate_admin
    flag = Admin.userAdmin?(session[:user])
    if flag == "1"
      return true
    else
      redirect_to :controller => 'app', :action => 'messageUserLogin', :token => "admin"
      return
    end
  end
    
  
  
end
