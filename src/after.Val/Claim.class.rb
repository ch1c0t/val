def initialize array
  @proc = array.to_proc
end

def proc
  @proc
end

def === value
  @proc === value
rescue
  false
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
