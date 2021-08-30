class String
  def is_alpha?
    return false if empty?
  
    downcase.ord.between?(97, 122) && length == 1
  end
end