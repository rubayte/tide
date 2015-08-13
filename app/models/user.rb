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
    
    ## validate user email and pass
    validateUser = "select userPass,userPassSalt from users where userEmail = '" + params[:email]+ "'"
    refvalidateUser = con.query(validateUser)
    if refvalidateUser.num_rows > 0
      refvalidateUser.each do |r1,r2|
        dbpass = r1
        dbsalt = r2
      end
      ## lets add salt to login password to match with the one in database
      passnewtomatch = BCrypt::Engine.hash_secret(params[:password],dbsalt)    
      if (passnewtomatch == dbpass)
        msg = "valid" 
      else
        msg = passnewtomatch
      end
    else
      msg = "invalid"
    end
    
    con.close()
    
    return msg 
    
  end


end
