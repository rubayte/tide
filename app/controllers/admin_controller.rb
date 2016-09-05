class AdminController < ApplicationController

  before_filter :authenticate_admin, :only => [:adminDashboard ]

  def adminDashboard
    (@orderOverview,@executedOrders) = Admin.getOrderOverview()
    @tabactive = "dashboard"
  end
  
  def admintideplans
    @plans = Admin.getplans()
    @tabactive = "plans"
  end

  def admintideusers
    @users = Admin.getusers()
    @tabactive = "users"
  end

  def admintideorders
    @orders = Admin.getorders()
    @tabactive = "orders"
  end

  def admintidetickets
    (@tickets,@closedTickets) = Admin.gettickets()
    @tabactive = "tickets"
  end
  
  def toggleTicketStatus
    (@msg,status) = Admin.toggleUserTicketStatus(params,session[:user])
    if @msg == "success"
      redirect_to :controller => "admin", :action => "admintidetickets"
      flash[:notice] = "User ticket " + status +"."
      flash[:color]= "valid"
      return
    else
      redirect_to :controller => "admin", :action => "admintidetickets"
      flash[:notice] = "Something went wrong. Try again."
      flash[:color]= "invalid"
      return
    end      
  end
  
  def toggleAQStatus
    (@msg,status) = Admin.toggleAnonymousTicketStatus(params,session[:user])
    if @msg == "success"
      redirect_to :controller => "admin", :action => "admintidequestions"
      flash[:notice] = "User ticket " + status +"."
      flash[:color]= "valid"
      return
    else
      redirect_to :controller => "admin", :action => "admintidequestions"
      flash[:notice] = "Something went wrong. Try again."
      flash[:color]= "invalid"
      return
    end
  end

  def admintidequestions
    (@questions,@closedquestions) = Admin.getquestions()
    @tabactive = "questions"
  end

  def authorizeOrder
    @msg = Admin.authorizeOrderUser(params)
    if @msg == "authorized"
      redirect_to :controller => "admin", :action => "adminDashboard"
      flash[:notice] = "Order and user authorized."
      flash[:color]= "valid"
      return
    else
      redirect_to :controller => "admin", :action => "adminDashboard"
      flash[:notice] = "Something went wrong. Try again."
      flash[:color]= "invalid"
      return
    end  
  end
  
  def unauthorizeUser
    @msg = Admin.unauthorizeUser(params)
    if @msg == "unauthorized"
      redirect_to :controller => "admin", :action => "adminDashboard"
      flash[:notice] = "User unauthorized."
      flash[:color]= "valid"
      return
    else
      redirect_to :controller => "admin", :action => "adminDashboard"
      flash[:notice] = "Something went wrong. Try again."
      flash[:color]= "invalid"
      return
    end      
  end
  
  def add
    (@msg,raction) = Admin.createItem(params,session[:user])
    if (@msg == "created")
      redirect_to :controller => "admin", :action => raction
      flash[:notice] = "New " + params[:type] + " has been created."
      flash[:color]= "valid"
      return
    else
      redirect_to :controller => "admin", :action => raction
      flash[:notice] = "Something went wrong. Try again."
      flash[:color]= "invalid"
      return      
    end
  end
  
  def archive
    ## need to implement
    redirect_to :controller => "admin", :action => "adminDashboard"
    flash[:notice] = "Under development"
    flash[:color]= "invalid"
    return
  end
  
  def edit
    ## need to implement
    redirect_to :controller => "admin", :action => "adminDashboard"
    flash[:notice] = "Under development"
    flash[:color]= "invalid"
    return
  end
  
end
