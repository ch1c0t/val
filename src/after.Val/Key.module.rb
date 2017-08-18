def self.new name, condition 
  if [Module, Val].any? &[condition, :is_a?]
    Type.new name, condition
  else
    Array.new name, condition
  end
end

attr_reader :name, :condition

def initialize name, condition = nil
  @name, @condition = name, condition
end

def === value
  self[value].ok?
end

def valid? value
  !!value
end

def [] value
  Instance.new self, value
end

class Instance
  attr_reader :type, :value, :error

  def initialize type, value
    @value = value[type.name]
    @ok = type.valid? @value
    @type = type.condition
  rescue
    @error = $!
    @ok = false
  end

  def ok?
    @ok
  end
end
