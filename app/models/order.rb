class Order
  

  def self
    con = Mysql.connect('127.0.0.1', 'wwwUser', 'wwwpublic', 'tide')
    return con
  end
  
  
  ## create new order
  def self.createNewOrder(params)
    
    msg = nil
    con = Order.new.self
    pass =nil
    salt = nil
    planid = nil
    
    ## generate random password
    pass = generate_random_password(params[:email])
    
    ## add salt to password
    (pass,salt) = encrypt_password(pass)
    
    ## create new user
    createUser = "insert into users values('"+ params[:email]+"', '"+ params[:name]+"','"+ params[:organization]+"','"+ params[:organizationAddress]+"','"+ params[:contactNumber]+"','"+ params[:webAddress]+"','"+ 
    pass+"','"+ salt +"',1,0,0,NOW(),NOW())"
    refCreateUser = con.query(createUser)
    msg = "created"
    
    ## map order type
    queryPlan = "select planName,id from plans where planName = '" + params[:chosenPlan]+ "'"
    refQueryPlan = con.query(queryPlan)
    refQueryPlan.each do |r1,r2|
      planid = r2
    end  
    
    ## place an order
    createOrder = "insert into `user_ordered_plans`(user,planid,`isAuthorized?`,createdAt,lastEditAt) values('"+ params[:email] +"',"+ planid +",0,NOW(),NOW())"
    refCreateOrder = con.query(createOrder)
    msg = "created"
    
    con.close()
    
    return msg
    
  end
  

  ## encrypt password
  def self.encrypt_password(password)
    salt = ""
    encrypted_password = ""
    unless password.blank?
      salt = BCrypt::Engine.generate_salt
      encrypted_password = BCrypt::Engine.hash_secret(password, salt)
    end
    return encrypted_password,salt
  end

  ## create random password
  def self.generate_random_password(email)
    
    pass = nil
    temp = email.split("@")
    pass = temp[0]
    
    return pass
    
  end


end
