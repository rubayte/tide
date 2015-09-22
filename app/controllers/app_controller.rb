class AppController < ApplicationController

  def index
    
  end 

  def order
    @selectedPlan = "Select a plan"
    if params[:selectedPlan] != nil or params[:selectedPlan] != ""
      @selectedPlan = params[:selectedPlan]
    end    
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
  
  def reqInfoAction
    
    msg = nil
    msg = Tickets.createAnonymousTicket(params)
    if msg == "created"
      redirect_to :controller => "app", :action => "messageUserLogin", :token => "reqInfo"
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
    elsif params[:token] == "order" or params[:token] == "reqInfo"
      @msg = "Your request has been recorded. Check your email for further details!"
    else
      @msg= "You can not login at this moment. Please try again later."
    end
  end
  
  
end