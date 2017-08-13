require 'to_proc/all'

include DSL

def initialize &block
  @conditions, @messages, @keys = [], {}, {}
  instance_exec &block
end

attr_reader :messages, :keys
def assertions
  [*@conditions, *@messages.values, *@keys.values]
end

def === value
  assertions.all? &[:===, value]
end

def [] value
  Instance.new self, value
end

Bool = new { OR(true, false) }
