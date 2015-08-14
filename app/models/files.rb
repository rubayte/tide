class Files
  

  def self
  end
  
  ## get all files by location
  def self.getFilesByLocation(location)
    
    allfiles = []
    
    Dir.foreach(Rails.root.join(location)) do |file|
      next if file == "." or file == ".."
        temp = []
        if (file =~ /.pdf$/)
          filename = file.split('v')
          version = filename[1][0..-5]
          temp.push(file)
          temp.push('NA')
          temp.push(version)
        else
          filename = file.split('.')
          fs = filename[0].split('-')
          version = fs[1]
          temp.push(file)
          if file =~ /.gz$/
            temp.push('Linux/Mac')  
          else
            temp.push('Windows')
          end
          temp.push(version)
        end    
        allfiles.push(temp)
    end  
    
    return allfiles    
  end  


end
