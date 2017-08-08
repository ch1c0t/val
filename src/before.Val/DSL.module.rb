def OR *all
  Op::OR[*all]
end

def val &block
  self.class.new &block
end

def key name, *conditions
  first = conditions.first

  if [Module, Val, NilClass].any? &[first, :is_a?]
    type = first
    @conditions << Key.new(name, type)
  else
    @conditions.concat conditions.map { |array|
      ArrayCondition.new name, array
    }
  end
end

def is_a type
  condition = -> value { value.is_a? type }
  @conditions << condition
end

def is array
  condition = -> value {
    begin
      array.to_proc === value
    rescue TypeError, ArgumentError
      false
    end
  }
  @conditions << condition
end

def m name
  condition = -> value {
    value.respond_to? name
  }
  @conditions << condition
end
