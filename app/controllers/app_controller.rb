class AppController < ApplicationController

  def index
    
  end 

  def order
        
  end
  
  def orderAction
    
    msg = nil
    msg = Order.createNewOrder(params)
    if msg == "created"
      redirect_to :controller => "app", :action => "messageUserLogin", :token => "order"
      return
    else
      redirect_to :order
      flash[:notice] = "try again!"
      flash[:color]= "invalid"
      return
    end
    
  end
  
  def messageUserLogin
    @msg = nil
    @header = params[:token]
    if params[:token] == "login"
      @msg = "You need to login to view this page."
    elsif params[:token] == "user"
      @msg= "You can not login at this moment. Please try again later."
    elsif params[:token] == "order"
      @msg = "Your details have been recorded. Check your email for further details!"
    else
      @msg= "You can not login at this moment. Please try again later."
    end
  end
  
  
end