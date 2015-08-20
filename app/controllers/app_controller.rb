class AppController < ApplicationController

  def index
    
  end 

  def order
    
  end
  
  def orderAction
    
    msg = nil
    msg = Order.createNewOrder(params)
    if msg == "created"
      redirect_to :order
      return
    else
      redirect_to :order
      flash[:notice] = "try again!"
      flash[:color]= "invalid"
      return
    end
    
  end
  
  def messageUserLogin
    
  end
  
  
end