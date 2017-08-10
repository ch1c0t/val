include Key

def initialize name, array
  @name, @proc = name, array.to_proc
end

def valid? value
  @proc === value
rescue ArgumentError
  false
end