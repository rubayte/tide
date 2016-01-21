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
    
    ## make pre validation
    ## check if an option has been choosen or not
    if (params[:chosenPlan] =~ /Select/)
      redirect_to :controller => "app", :action => "index", :anchor => "request"
      flash[:notice] = "You must select an option first!"
      flash[:color]= "invalid"
      return
    end
    ## check for empty or nil fields    
    msg = Prevalidate.validateEmptyString(params)
    
    if (msg == "pass")
      msgurl = Prevalidate.validateURL(params[:webAddress])
      msgnumber = Prevalidate.validateNumbers(params[:contactNumber])
      if msgurl == "pass" and msgnumber == "pass"
        msg = Order.createNewOrder(params)
        if msg == "created"
          redirect_to :controller => "app", :action => "messageUserLogin", :token => "order"
          return
        elsif msg == "authorized_user"
          redirect_to :controller => "app", :action => "index", :anchor => "request"
          flash[:notice] = "You are already an authorized user of the tide software package. If you want to request for a new option, then please <a class='page-scroll' href='#contact'>contact us</a>".html_safe
          flash[:color]= "valid"
          return
        elsif msg == "authorized_order"
          redirect_to :controller => "app", :action => "index", :anchor => "request"
          flash[:notice] = "Something went wrong. Please <a class='page-scroll' href='#contact'>contact us</a>".html_safe
          flash[:color]= "invalid"
          return
        elsif msg == "unathorized_order"
          redirect_to :controller => "app", :action => "index", :anchor => "request"
          flash[:notice] = "Your request has not been verified yet. You will be contacted soon."
          flash[:color]= "valid"
          return
        else
          redirect_to :controller => "app", :action => "index", :anchor => "request"
          flash[:notice] = "try again!"
          flash[:color]= "invalid"
          return
        end
      elsif msgurl == "invalid_url" and msgnumber == "pass"
        redirect_to :controller => "app", :action => "index", :anchor => "request"
        flash[:notice] = "Your web address is not correct. Please check again! (examples: http://www.foo.com, https://www.foo.com, http://www.foo.com/mypage )"
        flash[:color]= "invalid"
        return
      elsif msgnumber == "invalid_number" and msgurl 
        redirect_to :controller => "app", :action => "index", :anchor => "request"
        flash[:notice] = "Your phone number is not correct or too long. Only use digits."
        flash[:color]= "invalid"
        return
      elsif msgurl == "invalid_url" and msgnumber == "invalid_number"
        redirect_to :controller => "app", :action => "index", :anchor => "request"
        flash[:notice] = "Your web address is not correct. Please check again! (examples: www.foo.com, http://www.foo.com, https://www.foo.com, http://www.foo.com/mypage ). </br> Your phone number is also not correct or too long. Only use digits.".html_safe
        flash[:color]= "invalid"
        return
      else
        redirect_to :controller => "app", :action => "index", :anchor => "request"
        flash[:notice] = "try again!"
        flash[:color]= "invalid"
        return
      end    
     elsif msg == "empty"
      redirect_to :controller => "app", :action => "index", :anchor => "request"
      flash[:notice] = "All fields are mandatory!"
      flash[:color]= "invalid"
      return
    else
      redirect_to :controller => "app", :action => "index", :anchor => "request"
      flash[:notice] = "try again!"
      flash[:color]= "invalid"
      return
    end      
    
  end
  
  def reqInfoAction
    
    msg = nil
    
    ## make pre validation
    msg = Prevalidate.validateEmptyString(params)
    
    if (msg == "pass")
      msg = Tickets.createAnonymousTicket(params)
      if msg == "created"
       redirect_to :controller => "app", :action => "messageUserLogin", :token => "reqInfo"
       return
      else
        redirect_to :controller => "app", :action => "index", :anchor => "contact"
        flash[:notice] = "try again!"
        flash[:color]= "invalid"
        return  
      end
    elsif msg == "empty"
      redirect_to :controller => "app", :action => "index", :anchor => "contact"
      flash[:notice] = "All fields are mandatory!"
      flash[:color]= "invalid"
      return
    else
      redirect_to :controller => "app", :action => "index", :anchor => "contact"
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
      @msg = "Your request has been recorded. You will be contacted soon!"
    else
      @msg= "You can not login at this moment. Please try again later."
    end
  end
  
  
end