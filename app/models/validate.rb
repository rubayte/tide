class Validate
  
  def self
    
  end
  
  def self.validateEmail(email)

    response = EmailVerifier.check(email)
    return response
        
  end
  
  def self.validateMySQLStrings(string)
    
    string.gsub!("'","")
    string.gsub!("\"","")
    return string
    
  end
  
  
end