class Admin
  

  def self
    con = Mysql.connect('127.0.0.1', 'wwwUser', 'wwwpublic', 'tide')
    return con
  end
  
  ## toggle anonymous question status
  def self.toggleAnonymousTicketStatus(params, user)

    msg = nil
    targetStatus = nil
    
    if (params[:status] == "open")
      targetStatus = 'closed'
    elsif (params[:status] == "closed")
      targetStatus = 'open'
    else
      return nil,nil
    end
    
    con = Admin.new.self
    ## unauthorize the user
    queryAuthUser = "update `anonymous_tickets` set `status` = '"+ targetStatus +"', lastEditAt = NOW(), lastEditBy = '"+ user + "' where id = '" + params[:id] + "'"
    refqueryAuthUser = con.query(queryAuthUser)
    con.close()
    
    msg = "success"
    
    return msg,targetStatus

  end
  
  ## toggle user ticket status
  def self.toggleUserTicketStatus(params, user)

    msg = nil
    targetStatus = nil
    
    if (params[:status] == "open")
      targetStatus = 'closed'
    elsif (params[:status] == "closed")
      targetStatus = 'open'
    else
      return nil,nil
    end
    
    con = Admin.new.self
    ## unauthorize the user
    queryAuthUser = "update `user_created_tickets` set `status` = '"+ targetStatus +"', lastEditAt = NOW(), lastEditBy = '"+ user + "' where id = '" + params[:id] + "'"
    refqueryAuthUser = con.query(queryAuthUser)
    con.close()
    
    msg = "success"
    
    return msg,targetStatus
    
  end
  
  ## unathorize user
  def self.unauthorizeUser(params)

    msg = nil
    
    con = Admin.new.self
    ## unauthorize the user
    queryAuthUser = "update `users` set `isAuthorized?` = 0, lastEditAt = NOW() where userEmail = '" + params[:email] + "'"
    refqueryAuthUser = con.query(queryAuthUser)
    con.close()
    
    msg = "unauthorized"
    
    return msg
    
  end
  
  ## authorize order and user
  def self.authorizeOrderUser(params)
    
    msg = nil
    
    con = Admin.new.self
    ## authorize the order first
    queryAuthOrder = "update `user_ordered_plans` set `isAuthorized?` = 1, lastEditAt = NOW() where id = " + params[:id] + ""
    refqueryAuthOrder = con.query(queryAuthOrder)
    ## authorize the user now
    queryAuthUser = "update `users` set `isAuthorized?` = 1, lastEditAt = NOW() where userEmail = '" + params[:email] + "'"
    refqueryAuthUser = con.query(queryAuthUser)
    con.close()
    
    msg = "authorized"
    
    return msg
    
  end
  
  ## user is admin
  def self.userAdmin?(user)
    
    isadmin = nil
    
    con = Admin.new.self
    query = "select userEmail,`isAdmin?` from users where userEmail = '" + user + "'"
    refquery = con.query(query)
    if refquery.num_rows > 0
      refquery.each do |r1,r2|
        isadmin = r2
      end  
    end
    con.close()
    
    return isadmin
    
  end
    
  
  ## get order overview
  def self.getOrderOverview()
    
    data = []
    dataOld = []
    
    con = Admin.new.self
    ## get new orders
    queryOverview = "select U.userEmail,U.userFullName,U.userOrganization,U.userOrganizationAddress,U.userContactNumber,U.userOrganizationUrl,PN.planName,P.createdAt,P.lastEditAt,P.id from `user_ordered_plans` as P inner join `users` as U on P.user = U.userEmail inner join plans PN on P.planId = PN.Id where P.`isAuthorized?` = 0"
    refqueryOverview = con.query(queryOverview)
    if (refqueryOverview.num_rows > 0)
      refqueryOverview.each do |items|
        temp = []
        items.each do |item|
          temp.push(item)
        end  
        data.push(temp)
      end    
    end

    ## get executed orders
    queryOverview = "select U.userEmail,U.userFullName,U.userOrganization,U.userOrganizationAddress,U.userContactNumber,U.userOrganizationUrl,PN.planName,P.createdAt,P.lastEditAt,P.id from `user_ordered_plans` as P inner join `users` as U on P.user = U.userEmail inner join plans PN on P.planId = PN.Id where P.`isAuthorized?` = 1"
    refqueryOverview = con.query(queryOverview)
    if (refqueryOverview.num_rows > 0)
      refqueryOverview.each do |items|
        temp = []
        items.each do |item|
          temp.push(item)
        end  
        dataOld.push(temp)
      end    
    end


    con.close()
    
    return data,dataOld
    
  end
  
  ## get create items
  def self.createItem(params,user)
    
    msg = nil
    query = nil
    returnaction = nil
    
    item = params[:type]
    if item == "plan"
      query = "insert into plans(planName,createdAt,lastEditAt) values('" + validate(params[:planname]) + "',NOW(),NOW())"
      returnaction = "admintideplans"
    elsif item == "user"
      returnaction = "admintideusers"
      pass = Order.generate_random_password(params[:useremail])
      (pass,salt) = Order.encrypt_password(pass)  
      query = "insert into users values('" + validate(params[:useremail]) + "','" + validate(params[:userfullname]) + "','"+ validate(params[:org]) + "','" + validate(params[:address]) + "','" + validate(params[:contactno]) + "','" + validate(params[:url]) + "','" + pass + "','" + salt + "',1,0,0,NOW(),NOW())"
    elsif item == "order"
      returnaction = "admintideorders"
      planid = getPlanIdByName(params[:planname])
      query = "insert into `user_ordered_plans`(user,planid,`isAuthorized?`,createdAt,lastEditAt) values('" + validate(params[:useremail]) + "'," + planid + ",0,NOW(),NOW())"
    elsif item == "ticket"
      returnaction = "admintidetickets"
      query = "insert into `user_created_tickets`(user,ticket,status,createdAt,lastEditAt,lastEditBy) values('"+ user + "','" + validate(params[:ticket])+ "','open',NOW(),NOW(),'" + user + "')"
    elsif item == "question"
      returnaction = "admintidequestions"
      query = "insert into `anonymous_tickets`(email,name,ticket,plan,status,createdAt,lastEditAt,lastEditBy) values('"+ user + "','" + user +"','" + validate(params[:ticket])+ "',0,'open',NOW(),NOW(),'" + user + "')"
    else
    end
    
    con = Admin.new.self
    refquery = con.query(query)
    con.close()
    msg = "created"
    
    return msg,returnaction
    
  end
  
  ## get plan name from plan id
  def self.getPlanIdByName(pname)
    
    id = nil
    
    con = Admin.new.self
    queryPlan = "select planName,id from plans where planName = '" + pname + "'"
    refQueryPlan = con.query(queryPlan)
    refQueryPlan.each do |r1,r2|
            id = r2
    end
    con.close()
    
    return id
      
  end
  
  ## validate string with checks
  def self.validate(str)
    
    ## need to implement
    return str
    
  end
  
  ## get all plans
  def self.getplans()
    
    plans = []
    
    con = Admin.new.self
    queryPlan = "select * from plans"
    refqueryPlan = con.query(queryPlan)
    if (refqueryPlan.num_rows > 0)
      refqueryPlan.each do |items|
        temp = []
        items.each do |item|
          temp.push(item)
        end  
        plans.push(temp)
      end    
    end
    con.close()
    
    return plans
    
  end
  
  ## get all users
  def self.getusers()
    
    users = []
    
    con = Admin.new.self
    queryUser = "select `userEmail`,`userFullName`,`userOrganization`,`userOrganizationAddress`,`userContactNumber`,`userOrganizationUrl`,`updatePass?`,`isAdmin?`,`isAuthorized?`,`createdAt`,`lastEditAt` from users"
    refqueryUser = con.query(queryUser)
    if (refqueryUser.num_rows > 0)
      refqueryUser.each do |items|
        temp = []
        items.each do |item|
          temp.push(item)
        end  
        users.push(temp)
      end    
    end
    con.close()
    
    return users
    
  end
  
  ## get all user orders
  def self.getorders()
    
    orders = []
    
    con = Admin.new.self
    queryOrder = "select U.`user`,P.`planName`,U.`planId`,U.`isAuthorized?`,U.`createdAt`,U.`lastEditAt`,U.`id` from user_ordered_plans as U inner join plans as P where U.planId = P.id"
    refqueryOrder = con.query(queryOrder)
    if (refqueryOrder.num_rows > 0)
      refqueryOrder.each do |items|
        temp = []
        items.each do |item|
          temp.push(item)
        end  
        orders.push(temp)
      end    
    end
    con.close()
    
    return orders
    
  end  
  
  
  ## get all user tickers
  def self.gettickets()
    
    tickets = []
    closedtickets = []
    
    con = Admin.new.self
    queryTicket = "select * from user_created_tickets"
    refqueryTicket = con.query(queryTicket)
    if (refqueryTicket.num_rows > 0)
      refqueryTicket.each do |items|
        temp = []
        items.each do |item|
          temp.push(item)
        end
        if items[2] == "open"
          tickets.push(temp)
        else
          closedtickets.push(temp)            
        end
      end    
    end
    con.close()
    
    return tickets,closedtickets
    
  end  

  ## get all anonymous questions
  def self.getquestions()
    
    questions = []
    closedquestions = []
    
    con = Admin.new.self
    queryQuestion = "select * from anonymous_tickets"
    refqueryQuestion = con.query(queryQuestion)
    if (refqueryQuestion.num_rows > 0)
      refqueryQuestion.each do |items|
        temp = []
        items.each do |item|
          temp.push(item)
        end  
        if items[4] == 'open'
          questions.push(temp)
        else
          closedquestions.push(temp)
        end    
      end    
    end
    con.close()
    
    return questions,closedquestions
    
  end  


end
