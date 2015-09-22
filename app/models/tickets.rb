class Tickets
  
  def self
    con = Mysql.connect('127.0.0.1', 'wwwUser', 'wwwpublic', 'tide')
    return con
  end
  
  def self.createAnonymousTicket(params)
    
    msg = nil
    con = Tickets.new.self
    planid = nil
    
    ## map plan to db
    queryPlan = "select planName,id from plans where planName = '" + params[:plan]+ "'"
    refQueryPlan = con.query(queryPlan)
    refQueryPlan.each do |r1,r2|
      planid = r2
    end 

    ## create ticket in app database
    createTicket = "insert into `anonymous_tickets`(email,name,ticket,plan,status,createdAt,lastEditAt,lastEditBy) values('"+params[:email]+"','"+params[:name]+"','"+ params[:question]+"',"+planid+",'open',NOW(),NOW(),'-')"
    refcreateTicket = con.query(createTicket)
    msg = "created"
    ## create the same ticket in atlassian jira
    #data = "{\\\"fields\\\":{\\\"project\\\":{\\\"key\\\":\\\"SUP\\\"},\\\"summary\\\":\\\"tide-#{user}\\\",\\\"description\\\":\\\"#{params[:ticket]}\\\",\\\"issuetype\\\":{\\\"name\\\":\\\"Task\\\"},\\\"customfield_10004\\\":2}}"
    #issuecreateCmd = "curl -D- -u user:pass -X POST --data \"#{data}\" -H \"Content-Type: application/json\" https://nki-research-it.atlassian.net/rest/api/latest/issue/"
    #system(issuecreateCmd)
    msg = "created"
    con.close()
    
    return msg

    
  end
  
  def self.createNewTicket(params,user)
    
    msg = nil
    con = Tickets.new.self

        
    ## create ticket in app database
    createTicket = "insert into `user_created_tickets`(user,ticket,status,createdAt,lastEditAt,lastEditBy) values('"+user+"','"+params[:ticket]+"','open',NOW(),NOW(),'-')"
    refcreateTicket = con.query(createTicket)
    msg = "created"
    ## create the same ticket in atlassian jira
    #data = "{\\\"fields\\\":{\\\"project\\\":{\\\"key\\\":\\\"SUP\\\"},\\\"summary\\\":\\\"tide-#{user}\\\",\\\"description\\\":\\\"#{params[:ticket]}\\\",\\\"issuetype\\\":{\\\"name\\\":\\\"Task\\\"},\\\"customfield_10004\\\":2}}"
    #issuecreateCmd = "curl -D- -u user:pass -X POST --data \"#{data}\" -H \"Content-Type: application/json\" https://nki-research-it.atlassian.net/rest/api/latest/issue/"
    #system(issuecreateCmd)
    msg = "created"
    con.close()
    
    return msg
    
  end
  
  def self.getTicketsByUser(user)
    
    tickets = []
    
    con = Tickets.new.self
    ## get all tickets from this user
    queryTickets = "select ticket, createdAt, lastEditAt, status from `user_created_tickets` where user = '" + user + "'"
    refqueryTickets = con.query(queryTickets)
    con.close()
    
    if refqueryTickets.num_rows > 0
      refqueryTickets.each do |items|
        temp = []
        items.each do |item|
          temp.push(item)
        end  
        tickets.push(temp)
      end  
    end
    
    return tickets, refqueryTickets.num_rows
    
  end  
      

end