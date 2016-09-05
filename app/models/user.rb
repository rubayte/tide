class User
  

  def self
    con = Mysql.connect('127.0.0.1', 'wwwUser', 'wwwpublic', 'tide')
    return con
  end
  
  ## check if user exists in the database
  def self.userStatus(email)
    
    user = false
    authorized = false
    
    con = User.new.self
    queryUser = "select userEmail, `isAuthorized?` from users where userEmail = '" + email + "'"
    refqueryUser = con.query(queryUser)
    if (refqueryUser.num_rows == 0)
      return user,authorized
    else
      refqueryUser.each do |mail,status|
        user = mail
        authorized = status
      end    
    end
        
    return user,authorized
        
  end
  
  ## get user detials by mail
  def self.getUserDetailsByEmail(user)
    
    details = Hash.new
    con = User.new.self
    
    ## get user details
    queryUser = "select userEmail,userFullName,userOrganization,userOrganizationAddress,userContactNumber,userOrganizationUrl from users  where userEmail = '" + user + "'"
    refqueryUser = con.query(queryUser)
    refqueryUser.each do |mail,name,org,orgadd,contact,web|
      details['email'] = mail
      details['name'] = name
      details['org'] = org
      details['orgadd'] = orgadd
      details['contact'] = contact
      details['web'] = web
    end  
    
    con.close()
    
    return details
    
  end
  
  ## update user details by email
  def self.updateUserDetails(params)
    
    msg = nil
    con = User.new.self
    
    ## prepare update query part
    updateStr = "userFullName = '" + params[:name]+ "', userOrganization = '" + params[:institution]+ "',userOrganizationAddress = '" + 
    params[:institutionAddress]+ "',userContactNumber = '" + params[:contact]+ "', userOrganizationUrl = '" + params[:weburl]+ "', lastEditAt = NOW()"
    ## update user details 
    updateDetails = "update users set " + updateStr + " where userEmail = '" + params[:usermail] + "'"
    refupdateDetails = con.query(updateDetails)
    msg = "updated"
        
    return msg
    
  end
  
  ## validate user
  def self.getAuthentication(params)
    
    msg = nil
    con = User.new.self
    dbpass = nil
    dbsalt = nil
    updatePass= nil
    isAuthorized = nil
    isAdmin = nil
    
    ## validate user email and pass
    validateUser = "select userPass,userPassSalt,`updatePass?`,`isAuthorized?`,`isAdmin?` from users where userEmail = '" + params[:email]+ "'"
    refvalidateUser = con.query(validateUser)
    if refvalidateUser.num_rows > 0
      refvalidateUser.each do |r1,r2,r3,r4,r5|
        dbpass = r1
        dbsalt = r2
        updatePass = r3
        isAuthorized = r4
        isAdmin = r5
      end
    else
      msg = "invalid"
      return msg
    end
    con.close()

    ## if user is authorized then move forward with password check or return invalid
    if (isAuthorized == '1')
      ## lets add salt to login password to match with the one in database
      passnewtomatch = BCrypt::Engine.hash_secret(params[:password],dbsalt)    
      if (passnewtomatch == dbpass)
        if updatePass == '1'
          msg = "update_pass"
        else
          if isAdmin == '1'
            msg = "admin"
          else
            msg = "valid"
          end
        end
      else
        msg = "invalid"
      end      
    else
      msg = "invalid"  
    end
    
    return msg 
    
  end

  ## update password
  def self.changePassword(params)
    
    msg = nil
    con = User.new.self    
    pass =nil
    salt = nil

    ## add salt to password
    (pass,salt) = Order.encrypt_password(params[:password])

    updatePassword = "update users set userPass = '" + pass + "', userPassSalt ='" + salt + "', `updatePass?` = '0' where userEmail ='" + params[:usermail] + "'"
    refupdatePassword = con.query(updatePassword)
    msg = "updated"
    
    con.close()
    
    return msg
    
  end
  

end
