class User
  

  def self
    con = Mysql.connect('127.0.0.1', 'wwwUser', 'wwwpublic', 'tide')
    return con
  end
  
  ## validate user
  def self.getAuthentication(params)
    
    msg = nil
    con = User.new.self
    dbpass = nil
    dbsalt = nil
    updatePass= nil
    
    ## validate user email and pass
    validateUser = "select userPass,userPassSalt,`updatePass?` from users where userEmail = '" + params[:email]+ "'"
    refvalidateUser = con.query(validateUser)
    if refvalidateUser.num_rows > 0
      refvalidateUser.each do |r1,r2,r3|
        dbpass = r1
        dbsalt = r2
        updatePass = r3
      end
      ## lets add salt to login password to match with the one in database
      passnewtomatch = BCrypt::Engine.hash_secret(params[:password],dbsalt)    
      if (passnewtomatch == dbpass)
        if updatePass == '1'
          msg = "update_pass"
        else
          msg = "valid"
        end
      else
        msg = passnewtomatch
      end
    else
      msg = "invalid"
    end
    
    con.close()
    
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
