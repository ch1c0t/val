def initialize array
  @proc = array.to_proc
end

def === value
  @proc === value
rescue TypeError, ArgumentError
  false
end
