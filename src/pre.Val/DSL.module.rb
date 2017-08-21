def OR *all
  @claims << Op::OR[*all]
end

def NOT question
  @claims << Op::NOT[question]
end

def val &block
  self.class.new &block
end

def key name, *conditions
  conditions = [NotNil] if conditions.empty?
  conditions.each { |condition|
    @claims << Key.new(name, condition)
  }
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
