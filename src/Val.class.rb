require 'to_proc/all'

include DSL

def initialize &block
  @claims = []
  instance_exec &block
end

attr_reader :claims

def === value
  claims.all? &[:===, value]
end

def [] value
  Instance.new self, value
end

Bool = new { OR(true, false) }
