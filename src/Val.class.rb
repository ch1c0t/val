require 'to_proc/all'

include DSL

def initialize &block
  @claims = []
  instance_exec &block if block_given?
end

attr_reader :claims

def to_val
  self
end

def === value
  claims.all? &[:===, value]
end

def [] value
  Instance.new self, value
end

Bool = new { OR(true, false) }
NotNil = new { NOT :nil? }
