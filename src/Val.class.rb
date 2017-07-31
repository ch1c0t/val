require 'to_proc/all'

OR = -> *values do
  -> value do
    values.any? &[:===, value]
  end
end

def OR *all
  OR[*all]
end

def initialize &block
  @conditions = []
  if condition = (instance_exec &block)
    @conditions << condition
  end
end

class Key
  def initialize name, type
    @name, @type = name, type
  end

  def === value
    value.respond_to?(:[]) && value[@name] && valid_type?(value[@name])
  end

  def valid_type? name
    if @type
      @type === name
    else
      true
    end
  end
end

def key name, type = nil
  @conditions << Key.new(name, type)
  nil
end

def === value
  @conditions.all? &[:===, value]
end

Bool = new { OR[true, false] }
