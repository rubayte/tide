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
    user = false
    status = 0
    order_status = 0
    
    ## validate for single and double qoutes
    params[:name] = Validate.validateMySQLStrings(params[:name])
    params[:organization] = Validate.validateMySQLStrings(params[:organization])
    params[:organizationAddress] = Validate.validateMySQLStrings(params[:organizationAddress])
    params[:contactNumber] = Validate.validateMySQLStrings(params[:contactNumber])
    params[:webAddress] = Validate.validateMySQLStrings(params[:webAddress])
    
    # get initial status from users regarding this email
    (user, status) = User.userStatus(params[:email])
    
    if (user)
      ## user already present
      ## check on status
      if (status == "1")
        ## authorized user
        msg = "authorized_user"
      else
        ## unathorized user
        msg = "unathorized_user"
        ## get status of users order
        (planid,order_status) = orderDetails(user)
        if (planid!= nil)
          ## order from this user is found
          if (order_status == "1")
            msg = "authorized_order"
          else
            msg = "unathorized_order"
          end
        else
          ## no order found. place an order
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
        end
      end
    else
      ## create the new user  
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

    end  
    
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

  ## get order details
  def self.orderDetails(email)
    
    planid = nil
    status = nil
    con = Order.new.self
    queryOrder = "select planid,`isAuthorized?` from `user_ordered_plans` where user = '" + email + "'"
    refqueryOrder = con.query(queryOrder)
    if (refqueryOrder.num_rows == 0)
      return planid,status
    else
      refqueryOrder.each do |pid,s|
        planid = pid
        status = s
      end  
    end
    
    return planid,status
    
  end

  
end
