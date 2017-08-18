def OR *all
  @conditions << Op::OR[*all]
end

def val &block
  self.class.new &block
end

def key name, *conditions
  m :[]

  if conditions.empty?
    @keys[name] = Key::Presence.new name
  else
    conditions.each { |condition|
      @keys[name] = Key.new name, condition
    }
  end
end

def is_a type
  is [:is_a?, type]
end

def is array
  @conditions << Claim.new(array)
end

def m name, &block
  @messages[name] ||= Message.new name
  @messages[name].instance_exec &block if block_given?
end
