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
      session[:user] = params[:email]
      redirect_to :home
      return
    elsif msg == "update_pass"
      redirect_to :controller => "users", :action => "updatePass", :refemail => params[:email]
      return
    else
      redirect_to :controller => "app", :action => "index"
      return
    end 
  
  end
  
  def home
    @downloads = Files.getFilesByLocation("cur_downloads")
    @downloadsArchive = Files.getFilesByLocation("downloads")
    @tabactive = "dashboard"
    @userdetails = User.getUserDetailsByEmail(session[:user])
    (@tickets,@num_rows) = Tickets.getTicketsByUser(session[:user])
  end
  
  def tideproject
    @tabactive = "project"
  end
  
  def tideteam
    @tabactive = "team"
  end

  def tideplans
    @tabactive = "plans"
  end


  def logout
    session[:user] = nil
    redirect_to :controller => "app", :action => "index"
    return  
  end
  
  def updatePass
    @remail = params[:refemail]    
  end
  
  def createTicket
    
    msg = nil
    if params[:ticket] == "" or params[:ticket] == nil
      redirect_to :controller => "users", :action => "home"
      flash[:notice] = "all fields must be completed!"
      flash[:color]= "invalid"
      return  
    end
    msg = Tickets.createNewTicket(params,session[:user])
    if msg == "created"
      redirect_to :controller => "users", :action => "home"
      flash[:notice] = "Your ticket has been created!"
      flash[:color]= "valid"
      return
    else
      redirect_to :controller => "users", :action => "home"
      flash[:notice] = "Something went wrong. Try again!"
      flash[:color]= "invalid"
      return
    end
  end
  
  def confirmNewPassword

    msg = nil
    
    if params[:password] == "" or params[:password] == nil or params[:confirmPassword] == "" or params[:confirmPassword] == nil
      redirect_to :controller => "users", :action => "updatePass", :refemail => params[:usermail]
      flash[:notice] = "all fields must be completed!"
      flash[:color]= "invalid"
      return        
    end
    if params[:password] == params[:confirmPassword]
      msg = User.changePassword(params)
      if msg == "updated"
        redirect_to :home
        return
      else
        redirect_to :updatePass, :email => params[:email]
        flash[:notice] = "something went wrong. try again!"
        flash[:color]= "invalid"
        return  
      end
    else
      redirect_to :updatePass, :email => params[:email]
      flash[:notice] = "passwords dont match. try again!"
      flash[:color]= "invalid"
      return
    end  
  end
  
  def updateUserDetails
    
    msg = nil
    msg = User.updateUserDetails(params)
    if msg == "updated"
      redirect_to :home
      flash[:notice] = "Your information has been updated!"
      flash[:color]  = "valid"
    else
      redirect_to :home
      flash[:notice] = "Someting went wrong. Try again!"
      flash[:color]  = "invalid"  
    end
    
  end
  
  def download
    send_file Rails.root.join(params[:location], params[:file]), :disposition => 'attachment'
  end
  
  def view
    send_file(Rails.root.join(params[:location], params[:file]), :filename => params[:file], :disposition => 'inline', :type => "application/pdf")
  end
  
end