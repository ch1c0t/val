require 'to_proc/all'

include DSL

def initialize &block
  @conditions, @messages, @keys = [], [], []
  instance_exec &block
end

attr_reader :messages, :keys
def conditions
  [*@conditions, *@messages, *@keys]
end

def === value
  conditions.all? &[:===, value]
end

def [] value
  Report.new self, value
end

Bool = new { OR(true, false) }
