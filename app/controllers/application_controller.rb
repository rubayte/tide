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

  
  
end
