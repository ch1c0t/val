def OR *values
  claim = -> it { values.any? &[:===, it] }
  @claims << claim
end

def NOT question
  claim = -> it { not it.send question }
  @claims << claim
end

def val &block
  self.class.new &block
end

def key name, *conditions
  conditions = [NotNil] if conditions.empty?
  @claims += conditions.map { |condition| Key.new name, condition }
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
