def initialize array
  @array = array
  @proc = array.to_proc
end

def proc
  @proc
end

def to_a
  @array
end

def === value
  self[value].ok?
end

def [] value
  Instance.new self, value
end

class Instance
  attr_reader :type, :value, :error

  def initialize type, value
    @type, @value = type, value
    @ok = type.proc === value
  rescue
    @error = $!
    @ok = false
  end

  def ok?
    @ok
  end
end
