class ::Object
  def to_val
    type = Val.new
    type.is [self, :===]
    type
  end
end

class ::Array
  def to_val
    type = Val.new
    type.is self
    type
  end
end
