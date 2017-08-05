def initialize name, array
  @name, @proc = name, array.to_proc
end

def === value
  @proc === value[@name]
rescue ArgumentError
  false
end
