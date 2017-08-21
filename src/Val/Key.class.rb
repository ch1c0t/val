attr_reader :name, :type

def initialize name, condition
  @name, @type = name, condition.to_val
end

def === value
  self[value].ok?
end

def [] it
  Instance.new self, it
end

class Instance
  attr_reader :type, :name, :value, :error

  def initialize key, it
    @name, @type = key.name, key.type
    @value = it[@name]

    @ok = @type === @value
  rescue
    @error = $!
    @ok = false
  end

  def ok?
    @ok
  end
end
