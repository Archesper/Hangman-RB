class String
  def is_alpha?
    self.downcase.ord.between?(97, 122) && self.length == 1
  end
end