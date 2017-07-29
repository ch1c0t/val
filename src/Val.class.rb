require 'to_proc/all'

OR = -> *values do
  -> value do
    values.any? &[:===, value]
  end
end

def OR *all
  OR[*all]
end

Bool = new { OR[true, false] }

def initialize &block
  @type = instance_exec &block
end

def === value
  @type === value
end
