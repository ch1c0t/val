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
  @conditions = []
  if condition = (instance_exec &block)
    @conditions << condition
  end
end

class Key
  def initialize name
    @name = name
  end

  def === value
    value.respond_to?(:[]) && value[@name]
  end
end

def key name
  @conditions << Key.new(name)
  nil
end

def === value
  @conditions.all? &[:===, value]
end
