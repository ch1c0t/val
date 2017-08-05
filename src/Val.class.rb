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
  result = instance_exec &block
  if @conditions.empty?
    condition = result
    @conditions << condition
  end
end

def key name, *conditions
  first = conditions.first

  if [Module, Val, NilClass].any? &[first, :is_a?]
    type = first
    @conditions << Key.new(name, type)
  else
    @conditions.concat conditions.map { |array|
      ArrayCondition.new name, array
    }
  end
end

def is_a type
  condition = -> value { value.is_a? type }
  @conditions << condition
end

def === value
  @conditions.all? &[:===, value]
end

Bool = new { OR[true, false] }
