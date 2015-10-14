class Prevalidate
  
  def self
    
  end
  
  def self.validateEmail(email)

    response = EmailVerifier.check(email)
    return response
        
  end
  
  def self.validateURL(url)
    
    if (url =~ /\A#{URI::regexp(['http', 'https'])}\z/)
      return "pass"
    else 
      return "invalid_url"
    end
    
  end
  
  def self.validateNumbers(numbers)
    
    if (numbers =~ /^[0-9]+$/)
      return "pass"
    else
      return "invalid_number"
    end  
    
  end
  
  def self.validateEmptyString(params)
    
    msg = "pass"
    
    params.each do |key, value|
      if (isEmpty?(params[key]))
        msg = "empty"
        return msg
      end
    end
    
    return msg
    
  end
  
  def self.isEmpty?(string)
    
    if (string == nil)
      return true
    elsif (string == "")
      return true
    else
      return false    
    end
    
  end
  
  
end