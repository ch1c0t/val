def OR *all
  @conditions << Op::OR[*all]
end

def val &block
  self.class.new &block
end

def key name, *conditions
  if conditions.empty?
    @keys << Key::Presence.new(name)
  else
    @keys.concat conditions.map { |condition|
      Key.new name, condition
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
  @messages << Message.new(name)
end
