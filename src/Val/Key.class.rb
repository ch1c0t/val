attr_reader :name, :type

def initialize name, condition
  @name, @type = name, condition.to_val
end

def === value
  self[value].ok?
end

def [] value
  Instance.new self, value
end

class Instance
  attr_reader :type, :name, :value, :error

  def initialize type, value
    @name, @type = type.name, type.type
    @value = value[@name]

    @ok = @type === @value
  rescue
    @error = $!
    @ok = false
  end

  def ok?
    @ok
  end
end
