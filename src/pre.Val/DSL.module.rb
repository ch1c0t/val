def OR *all
  @claims << Op::OR[*all]
end

def val &block
  self.class.new &block
end

def key name, *conditions
  if conditions.empty?
    @claims << Key::Presence.new(name)
  else
    conditions.each { |condition|
      @claims << Key.new(name, condition)
    }
  end
end

def is_a type
  is [:is_a?, type]
end

def is array
  @claims << Claim.new(array)
end

def m name, &block
  message = Message.new name
  message.instance_exec &block if block_given?
  @claims << message
end
